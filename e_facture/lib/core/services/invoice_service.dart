import 'dart:convert';
import 'dart:io';
import 'package:e_facture/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/core/models/invoice.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class InvoiceService with ChangeNotifier {
  final String baseUrl = dotenv.get('API_URL') + dotenv.get('INVOICE_PATH');
  final Dio dio = Dio();

  List<Invoice> _invoices = [];
  bool _isLoading = false;
  String? _error;
  int _totalInvoices = 0;
  double _totalAmount = 0;
  var logger = Logger();

  List<Invoice> get invoices => _invoices;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalInvoices => _totalInvoices;
  double get totalAmount => _totalAmount;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  InvoiceService() {
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> fetchStats(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getToken(context);
      if (token == null) {
        throw Exception('Vous devez être connecté pour effectuer cette action');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/stats'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _totalInvoices = data['totalInvoices'];
        _totalAmount = data['totalAmount'];
      } else {
        throw Exception('Échec de récupération des statistiques');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> _getToken(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return authProvider.token;
  }

  Future<Map<String, dynamic>> createInvoice({
    required BuildContext context,
    required String userId,
    required double amount,
    required File file,
    required String fileName,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getToken(context);
      if (token == null) {
        throw Exception('Vous devez être connecté pour effectuer cette action');
      }

      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final formData = FormData.fromMap({
        'userId': userId,
        'amount': amount,
        'file': await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await dio.post(baseUrl, data: formData);

      if (response.statusCode == 201) {
        _isLoading = false;
        notifyListeners();
        return {
          'success': true,
          'message': 'Facture ajoutée avec succès',
          'invoice': response.data['invoice'],
        };
      } else {
        throw Exception('Échec de l\'ajout de la facture');
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': _error};
    }
  }

  Future<void> fetchUserInvoices(
    BuildContext context,
    String userId, {
    int? limit,
    int? offset,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getToken(context);
      if (token == null) {
        throw Exception('Vous devez être connecté pour effectuer cette action');
      }

      final int finalLimit = limit ?? 10;
      final int finalOffset = offset ?? 0;

      final response = await http.get(
        Uri.parse('$baseUrl/$userId?limit=$finalLimit&offset=$finalOffset'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> invoicesData = data['invoices'];

        _invoices.addAll(
          invoicesData.map((item) => Invoice.fromMap(item)).toList(),
        );
        _totalInvoices = data['totalInvoices'] ?? 0;
        _totalAmount = data['totalAmount'] ?? 0.0;
      } else {
        throw Exception('Échec de récupération des factures');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Invoice?> getInvoiceById(
    BuildContext context,
    String invoiceId,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getToken(context);
      if (token == null) {
        throw Exception('Vous devez être connecté pour effectuer cette action');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/$invoiceId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['invoice'];
        _isLoading = false;
        notifyListeners();
        return Invoice.fromMap(data);
      } else {
        throw Exception('Facture non trouvée');
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return null;
    }
  }

  static const String prefDownloadPath = 'download_path';

  Future<String?> getDefaultDownloadPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(prefDownloadPath);
  }

  Future<void> saveDefaultDownloadPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(prefDownloadPath, path);
  }

  Future<String?> _getDefaultDownloadFolder() async {
    try {
      if (Platform.isAndroid) {
        Directory? externalStorageDir = await getExternalStorageDirectory();
        if (externalStorageDir != null) {
          String basePath = externalStorageDir.path.split('Android')[0];
          return p.join(basePath, 'Download');
        }
        return '/storage/emulated/0/Download';
      } else if (Platform.isIOS) {
        Directory docDir = await getApplicationDocumentsDirectory();
        return docDir.path;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> _getDownloadPath() async {
    String? downloadPath = await getDefaultDownloadPath();

    if (downloadPath == null) {
      String? defaultPath = await _getDefaultDownloadFolder();

      if (defaultPath != null) {
        final directory = Directory(defaultPath);
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }

        downloadPath = await FilePicker.platform.getDirectoryPath();

        if (downloadPath != null) {
          await saveDefaultDownloadPath(downloadPath);
        } else {
          downloadPath = defaultPath;
          await saveDefaultDownloadPath(downloadPath);
        }
      } else {
        downloadPath = await FilePicker.platform.getDirectoryPath();
        if (downloadPath != null) {
          await saveDefaultDownloadPath(downloadPath);
        }
      }
    }

    return downloadPath;
  }

  Future<Map<String, dynamic>> downloadInvoice(
    BuildContext context,
    String invoiceId, {
    Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getToken(context);
      if (token == null) {
        throw Exception('Vous devez être connecté pour effectuer cette action');
      }

      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final urlResponse = await dio.get(
        '$baseUrl/$invoiceId/download',
        cancelToken: cancelToken,
      );

      if (urlResponse.statusCode != 200 ||
          urlResponse.data['success'] != true) {
        throw Exception('Échec de récupération de l\'URL de téléchargement');
      }

      final downloadUrl = urlResponse.data['downloadUrl'];
      final fileName = urlResponse.data['fileName'] ?? p.basename(downloadUrl);

      final String? selectedDirectory = await _getDownloadPath();
      if (selectedDirectory == null) {
        throw Exception('Aucun dossier sélectionné');
      }

      final savePath = p.join(selectedDirectory, fileName);

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'download_channel',
        'Téléchargements',
        description: 'Notifications pour les téléchargements',
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      const int notificationId = 0;

      await flutterLocalNotificationsPlugin.show(
        notificationId,
        'Téléchargement en cours',
        'Préparation du téléchargement...',
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: channel.importance,
            priority: Priority.high,
            showProgress: true,
            maxProgress: 100,
            progress: 0,
            ongoing: true,
            autoCancel: false,
          ),
        ),
      );

      await dio.download(
        downloadUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toInt();

            flutterLocalNotificationsPlugin.show(
              notificationId,
              'Téléchargement en cours',
              '$progress% complété',
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  importance: channel.importance,
                  priority: Priority.high,
                  showProgress: true,
                  maxProgress: 100,
                  progress: progress,
                  ongoing: true,
                  autoCancel: false,
                ),
              ),
            );

            if (onReceiveProgress != null) {
              onReceiveProgress(received, total);
            }
          }
        },
        cancelToken: cancelToken,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          responseType: ResponseType.bytes,
        ),
      );

      await flutterLocalNotificationsPlugin.show(
        notificationId,
        'Téléchargement terminé',
        'Le fichier a été enregistré dans $selectedDirectory',
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            importance: channel.importance,
            priority: Priority.high,
            ongoing: false,
            autoCancel: true,
          ),
        ),
      );

      _isLoading = false;
      notifyListeners();
      return {
        'success': true,
        'message': 'Facture téléchargée avec succès',
        'path': savePath,
      };
    } catch (e) {
      if (e is DioException && CancelToken.isCancel(e)) {
        _isLoading = false;
        notifyListeners();
        return {'success': false, 'message': 'Téléchargement annulé'};
      }

      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return {'success': false, 'message': _error};
    }
  }

  Future<void> fetchUserInvoicesWithDateFilter(
    BuildContext context, {
    String? startDate,
    String? endDate,
    int limit = 10,
    int offset = 0,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final token = await _getToken(context);
      if (token == null) throw Exception('Vous devez être connecté');

      final queryParams = {'limit': '$limit', 'offset': '$offset'};
      if (startDate != null) queryParams['startDate'] = startDate;
      if (endDate != null) queryParams['endDate'] = endDate;

      final uri = Uri.parse(baseUrl).replace(queryParameters: queryParams);

      logger.i('URI filtrage: $uri'); // Log pour debug

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> invoicesData = data['invoices'];

        if (offset == 0) {
          _invoices = []; // Reset list if fresh fetch
        }

        _invoices.addAll(
          invoicesData.map((item) => Invoice.fromMap(item)).toList(),
        );
        _totalInvoices = data['totalInvoices'] ?? 0;
      } else {
        logger.e('Erreur status code: ${response.statusCode}');
        throw Exception('Erreur récupération factures');
      }
    } catch (e) {
      logger.e('Erreur fetchUserInvoicesWithDateFilter: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetState() {
    _invoices = [];
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}

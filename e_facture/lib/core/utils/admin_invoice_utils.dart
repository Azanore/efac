import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:open_file/open_file.dart';
import 'package:e_facture/core/models/admin_invoice.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:e_facture/core/providers/auth_provider.dart';

class AdminInvoiceUtils {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> _initNotifications() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await _notifications.initialize(settings);
  }

  static Future<bool> _requestPermissions(BuildContext context) async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Permission de stockage requise."),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    }
    return true;
  }

  static Future<String> _getDownloadPath() async {
    Directory dir;
    if (Platform.isAndroid) {
      dir = (await getExternalStorageDirectory())!;
      return p.join(dir.path.split("Android")[0], "Download");
    } else {
      dir = await getApplicationDocumentsDirectory();
      return dir.path;
    }
  }

  static Future<void> handleDownloadForAdmin({
    required BuildContext context,
    required AdminInvoice adminInvoice,
    required ValueChanged<double> onProgress,
    required VoidCallback onStart,
    required Function(String message, bool success, String? path) onComplete,
  }) async {
    await _initNotifications();

    if (!await _requestPermissions(context)) return;

    onStart();

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.token;
      if (token == null) throw Exception("Non authentifié");

      final invoiceId = adminInvoice.invoice.id!;
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(
        "${dotenv.env['API_URL']}/admin/invoices/$invoiceId/download",
      );

      if (response.statusCode != 200 || response.data['success'] != true) {
        throw Exception("Erreur récupération de l'URL");
      }

      final downloadUrl = response.data['downloadUrl'];
      final fileName = response.data['fileName'] ?? p.basename(downloadUrl);

      final downloadPath = await _getDownloadPath();
      final savePath = p.join(downloadPath, fileName);

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'admin_invoice_download',
        'Téléchargement Admin',
        description: 'Notification pour le téléchargement admin',
        importance: Importance.high,
      );

      await _notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      const int notificationId = 42;

      await _notifications.show(
        notificationId,
        'Téléchargement en cours',
        'Préparation...',
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
          ),
        ),
      );

      await dio.download(
        downloadUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toInt();
            onProgress(received / total);

            _notifications.show(
              notificationId,
              'Téléchargement...',
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
                ),
              ),
            );
          }
        },
        options: Options(responseType: ResponseType.bytes),
      );

      if (context.mounted) {
        await _notifications.show(
          notificationId,
          'Téléchargement terminé',
          'Le fichier a été enregistré dans $downloadPath',
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: channel.importance,
              priority: Priority.high,
              autoCancel: true,
              ongoing: false,
            ),
          ),
        );
      }

      onComplete('Facture téléchargée avec succès', true, savePath);

      await OpenFile.open(savePath);
    } catch (e) {
      onComplete("Erreur: ${e.toString()}", false, null);
    }
  }
}

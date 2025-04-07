import 'package:flutter/material.dart';

import 'package:e_facture/core/services/invoice_service.dart';
import 'package:e_facture/core/providers/auth_provider.dart';
import 'package:e_facture/core/models/invoice.dart';

class UserInvoicesViewModel extends ChangeNotifier {
  final InvoiceService invoiceService;
  final AuthProvider authProvider;

  UserInvoicesViewModel({
    required this.invoiceService,
    required this.authProvider,
  });

  final ScrollController scrollController = ScrollController();

  int _offset = 0;
  final int _limit = 10;
  bool _isLoadingMore = false;
  bool _hasReachedEnd = false;
  bool _isFilterApplied = false;
  bool _showFilterOptions = false;
  bool _isGridView = true;
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _lastLoadTime;

  List<Invoice> get invoices => invoiceService.invoices;
  bool get isLoading => invoiceService.isLoading;
  String? get error => invoiceService.error;
  int get totalInvoices => invoiceService.totalInvoices;
  bool get isFilterApplied => _isFilterApplied;
  bool get showFilterOptions => _showFilterOptions;
  bool get isGridView => _isGridView;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasReachedEnd => _hasReachedEnd;
  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;

  void init(BuildContext context) {
    invoiceService.resetState();
    _offset = 0;
    _hasReachedEnd = false;
    _isFilterApplied = false;
    _showFilterOptions = false;
    _startDate = null;
    _endDate = null;
    _lastLoadTime = null;

    loadInvoices(context);
  }



  Future<void> loadInvoices(BuildContext context) async {
    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!).inMilliseconds < 300) {
      return;
    }

    _lastLoadTime = now;
    final userId = authProvider.userData?.id ?? '';
    if (userId.isEmpty || _isLoadingMore) return;

    try {
      _isLoadingMore = true;
      notifyListeners();

      await invoiceService.fetchUserInvoices(
        context,
        userId,
        limit: _limit,
        offset: _offset,
      );

      _offset += _limit;
      if (invoiceService.invoices.length >= invoiceService.totalInvoices) {
        _hasReachedEnd = true;
      }
    } catch (_) {
      // already handled
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> loadInvoicesWithFilter(BuildContext context) async {
    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!).inMilliseconds < 300) {
      return;
    }

    _lastLoadTime = now;

    try {
      _isLoadingMore = true;
      notifyListeners();

      final startDateAdjusted =
          _startDate != null
              ? DateTime(
                _startDate!.year,
                _startDate!.month,
                _startDate!.day,
                0,
                0,
                0,
              )
              : null;

      final endDateAdjusted =
          _endDate != null
              ? DateTime(
                _endDate!.year,
                _endDate!.month,
                _endDate!.day,
                23,
                59,
                59,
              )
              : null;

      await invoiceService.fetchUserInvoicesWithDateFilter(
        context,
        startDate: startDateAdjusted?.toIso8601String(),
        endDate: endDateAdjusted?.toIso8601String(),
        limit: _limit,
        offset: _offset,
      );

      _offset += _limit;
      if (invoiceService.invoices.length >= invoiceService.totalInvoices) {
        _hasReachedEnd = true;
      }
    } catch (_) {
      // already handled
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> refresh(BuildContext context) async {
    invoiceService.resetState();
    _offset = 0;
    _hasReachedEnd = false;
    _isFilterApplied = false;
    await loadInvoices(context);
  }

  void applyDateFilter(BuildContext context) {
    invoiceService.resetState();
    _offset = 0;
    _hasReachedEnd = false;
    _isFilterApplied = true;
    _showFilterOptions = false;
    loadInvoicesWithFilter(context);
  }

  void resetFilters(BuildContext context) {
    invoiceService.resetState();
    _offset = 0;
    _hasReachedEnd = false;
    _isFilterApplied = false;
    _startDate = null;
    _endDate = null;
    _showFilterOptions = false;
    loadInvoices(context);
  }

  void setStartDate(DateTime? date) {
    _startDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime? date) {
    _endDate = date;
    notifyListeners();
  }

  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  void toggleFilterOptions() {
    _showFilterOptions = !_showFilterOptions;
    notifyListeners();
  }

}

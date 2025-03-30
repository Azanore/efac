import 'package:e_facture/core/services/admin_invoice_service.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/widgets/custom_scrollbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/widgets/admin_invoice_list_item_widget.dart';
import 'package:logger/logger.dart';
import 'package:e_facture/generated/l10n.dart';

class AdminInvoicesPage extends StatefulWidget {
  final String? userId; // facultatif : null = toutes factures

  const AdminInvoicesPage({super.key, this.userId});

  @override
  State<AdminInvoicesPage> createState() => _AdminInvoicesPageState();
}

class _AdminInvoicesPageState extends State<AdminInvoicesPage> {
  int _offset = 0;
  bool _isLoadingMore = false;
  bool _hasReachedEnd = false;
  final int _limit = 10;
  final ScrollController _scrollController = ScrollController();
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _lastLoadTime;
  bool _expandAll = false;
  bool _showFilterOptions = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearchMode = false;
  final Logger _logger = Logger();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resetAndLoadInvoices();
    });
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _resetAndLoadInvoices() async {
    final invoiceService = Provider.of<AdminInvoiceService>(
      context,
      listen: false,
    );
    invoiceService.resetState();
    setState(() {
      _offset = 0;
      _hasReachedEnd = false;
      _searchQuery = '';
      _searchController.clear();
      _isSearchMode = false;
    });
    await _loadInvoices();
  }

  Future<void> _loadInvoices() async {
    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!).inMilliseconds < 300) {
      return;
    }
    _lastLoadTime = now;

    final invoiceService = Provider.of<AdminInvoiceService>(
      context,
      listen: false,
    );

    if (_isLoadingMore) return;

    try {
      setState(() => _isLoadingMore = true);
      // Ajustement des heures de début et fin de journée
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

      await invoiceService.fetchInvoices(
        context,
        widget.userId,
        limit: _limit,
        offset: _offset,
        startDate: startDateAdjusted?.toIso8601String(),
        endDate: endDateAdjusted?.toIso8601String(),
        keyword: _isSearchMode ? _searchQuery : null,
      );

      setState(() {
        _offset += _limit;
        if (invoiceService.adminInvoices.length >=
            invoiceService.totalInvoices) {
          _hasReachedEnd = true;
        }
      });
    } catch (e) {
      _logger.e('Erreur chargement factures admin: $e');
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        !_hasReachedEnd) {
      _loadInvoices();
    }
  }

  void _toggleExpandAll() {
    setState(() {
      _expandAll = !_expandAll;
    });
  }

  void _searchInvoices() {
    if (_searchController.text.trim().isEmpty) {
      return;
    }

    final invoiceService = Provider.of<AdminInvoiceService>(
      context,
      listen: false,
    );
    invoiceService.resetState();
    setState(() {
      _searchQuery = _searchController.text.trim();
      _offset = 0;
      _hasReachedEnd = false;
      _isSearchMode = true;
      _showFilterOptions = false;
    });
    _loadInvoices();
  }

  void _resetFilters() {
    final invoiceService = Provider.of<AdminInvoiceService>(
      context,
      listen: false,
    );
    invoiceService.resetState();
    setState(() {
      _startDate = null;
      _endDate = null;
      _showFilterOptions = false;
      _searchQuery = '';
      _searchController.clear();
      _isSearchMode = false;
      _offset = 0;
      _hasReachedEnd = false;
    });
    _loadInvoices();
  }

  Widget _buildFooterWidget() {
    final isDarkMode = AppColors.isDark(context);

    if (_isLoadingMore) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_hasReachedEnd) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            S.of(context).allInvoicesLoaded,
            style: TextStyle(
              fontSize: 14,
              color:
                  isDarkMode
                      ? AppColors.borderColor(context)
                      : AppColors.borderColor(context),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceService = Provider.of<AdminInvoiceService>(context);
    final isDarkMode = AppColors.isDark(context);

    return Scaffold(
      appBar: AppBarWidget(
        rightAction: QuickSettingsWidget(),
        title:
            widget.userId != null
                ? S.of(context).userInvoicesTitle
                : S.of(context).allInvoicesTitle,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.cardColor(context),
              boxShadow: [
                BoxShadow(
                  color: AppColors.backgroundColor(
                    context,
                  ).withAlpha((255 * 0.05).toInt()),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.filter_list,
                        color: AppColors.buttonTextColor,
                        size: 20,
                      ),
                      label: Icon(
                        _showFilterOptions
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.buttonTextColor,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _showFilterOptions = !_showFilterOptions;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            (_startDate != null ||
                                    _endDate != null ||
                                    _isSearchMode)
                                ? AppColors.primaryColor(context)
                                : AppColors.buttonColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color:
                              isDarkMode
                                  ? AppColors.backgroundColor(
                                    context,
                                  ).withAlpha((255 * 0.5).toInt())
                                  : Colors.white,
                          border: Border.all(
                            color: AppColors.borderColor(context),
                            width: 0.5,
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: S.of(context).searchInvoiceHint,
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.iconColor(
                                context,
                              ).withAlpha(180),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.primaryColor(context),
                              size: 20,
                            ),
                            suffixIcon:
                                _searchController.text.isNotEmpty
                                    ? IconButton(
                                      icon: Icon(Icons.clear, size: 16),
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                      onPressed: () {
                                        _searchController.clear();
                                        if (_isSearchMode) {
                                          _resetFilters();
                                        }
                                      },
                                    )
                                    : null,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textColor(context),
                            height: 1.2,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                          onSubmitted: (_) => _searchInvoices(),
                          textInputAction: TextInputAction.search,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    if (_startDate != null || _endDate != null || _isSearchMode)
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: AppColors.iconColor(context),
                        ),
                        onPressed: _resetFilters,
                        tooltip: S.of(context).clearFilterTooltip,
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                    IconButton(
                      icon: Icon(
                        _expandAll ? Icons.unfold_less : Icons.unfold_more,
                        color: AppColors.iconColor(context),
                      ),
                      onPressed: _toggleExpandAll,
                      tooltip:
                          _expandAll
                              ? S.of(context).collapseAllTooltip
                              : S.of(context).expandAllTooltip,
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                  ],
                ),
                if (_showFilterOptions)
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor(
                        context,
                      ).withAlpha((255 * 0.3).toInt()),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor(
                          context,
                        ).withAlpha((255 * 0.5).toInt()),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).filterByDate,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColors.textColor(context),
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: Icon(Icons.date_range, size: 16),
                                label: Text(
                                  _startDate != null
                                      ? S
                                          .of(context)
                                          .fromDateLabel(
                                            DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(_startDate!),
                                          )
                                      : S.of(context).startDateLabel,
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onPressed: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: _startDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    setState(() => _startDate = picked);
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: OutlinedButton.icon(
                                icon: Icon(Icons.date_range, size: 16),
                                label: Text(
                                  _endDate != null
                                      ? S
                                          .of(context)
                                          .toDateLabel(
                                            DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(_endDate!),
                                          )
                                      : S.of(context).endDateLabel,
                                  style: TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onPressed: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: _endDate ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    setState(() => _endDate = picked);
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _offset = 0;
                                _hasReachedEnd = false;
                                _showFilterOptions = false;
                              });
                              _loadInvoices();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor(context),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              S.of(context).applyFilter,
                              style: TextStyle(
                                color: AppColors.buttonTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if ((_startDate != null || _endDate != null || _isSearchMode) &&
                    !_showFilterOptions)
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor(context),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.borderColor(context),
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_startDate != null || _endDate != null)
                          Row(
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                size: 14,
                                color: AppColors.iconColor(
                                  context,
                                ).withAlpha(180),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Date: ${_startDate != null ? S.of(context).fromDateFilterDisplay(DateFormat('dd/MM/yyyy').format(_startDate!)) : ""}${_endDate != null ? " ${S.of(context).toDateFilterDisplay(DateFormat('dd/MM/yyyy').format(_endDate!))}" : ""}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textColor(context),
                                ),
                              ),
                            ],
                          ),
                        if (_isSearchMode)
                          Padding(
                            padding: EdgeInsets.only(
                              top:
                                  (_startDate != null || _endDate != null)
                                      ? 4
                                      : 0,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 14,
                                  color: AppColors.iconColor(
                                    context,
                                  ).withAlpha(180),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    S
                                        .of(context)
                                        .searchQueryDisplay(_searchQuery),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textColor(context),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).invoicesFoundCount(invoiceService.totalInvoices),

                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: AppColors.textColor(
                    context,
                  ).withAlpha((255 * 0.7).toInt()),
                ),
              ),
            ),
          ),

          Expanded(
            child:
                invoiceService.isLoading && _offset == 0
                    ? Center(child: CircularProgressIndicator())
                    : invoiceService.error != null
                    ? Center(
                      child: Text(
                        S
                            .of(context)
                            .errorPrefix(invoiceService.error ?? 'Unknown'),
                      ),
                    )
                    : RefreshIndicator(
                      onRefresh: _resetAndLoadInvoices,
                      child:
                          invoiceService.adminInvoices.isEmpty
                              ? Center(
                                child: Text(
                                  S.of(context).noInvoicesFound,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textColor(context),
                                  ),
                                ),
                              )
                              : CustomScrollbar(
                                controller: _scrollController,
                                slivers: [
                                  ...invoiceService.adminInvoices.map(
                                    (adminInvoice) =>
                                        AdminInvoiceListItemWidget(
                                          adminInvoice: adminInvoice,
                                          expandAll: _expandAll,
                                        ),
                                  ),
                                  _buildFooterWidget(),
                                ],
                              ),
                    ),
          ),
        ],
      ),
    );
  }
}

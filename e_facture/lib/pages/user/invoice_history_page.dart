import 'package:e_facture/core/services/auth_service.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/widgets/custom_scrollbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_facture/core/services/invoice_service.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/custom_card_widget.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/models/invoice.dart';
import 'package:intl/intl.dart';
import 'package:e_facture/widgets/custom_list_item_widget.dart';
import 'package:logger/logger.dart';

class UserInvoicesPage extends StatefulWidget {
  const UserInvoicesPage({super.key});

  @override
  _UserInvoicesPageState createState() => _UserInvoicesPageState();
}

class _UserInvoicesPageState extends State<UserInvoicesPage> {
  int _offset = 0;
  bool _isLoadingMore = false;
  bool _hasReachedEnd = false;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isGridView = true;
  bool _isFilterApplied = false;
  bool _showFilterOptions = false;
  final int _limit = 10;
  final ScrollController _scrollController = ScrollController();
  DateTime? _lastLoadTime;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _resetAndLoadInvoices(),
    );
    _scrollController.addListener(_scrollListener);
  }

  void _resetAndLoadInvoices() {
    final invoiceService = Provider.of<InvoiceService>(context, listen: false);
    invoiceService.resetState();
    setState(() {
      _offset = 0;
      _hasReachedEnd = false;
      _isFilterApplied = false;
    });
    _loadInvoices();
  }

  Future<void> _applyDateFilter() async {
    final invoiceService = Provider.of<InvoiceService>(context, listen: false);
    invoiceService.resetState();
    setState(() {
      _offset = 0;
      _hasReachedEnd = false;
      _isFilterApplied = true;
      _showFilterOptions = false;
    });
    await _loadInvoicesWithFilter();
  }

  void _resetFilters() {
    final invoiceService = Provider.of<InvoiceService>(context, listen: false);
    invoiceService.resetState();
    setState(() {
      _offset = 0;
      _hasReachedEnd = false;
      _isFilterApplied = false;
      _startDate = null;
      _endDate = null;
      _showFilterOptions = false;
    });
    _loadInvoices();
  }

  Future<void> _loadInvoices() async {
    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!).inMilliseconds < 300) {
      return;
    }
    _lastLoadTime = now;

    final invoiceService = Provider.of<InvoiceService>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userData?.id ?? '';
    if (userId.isEmpty || _isLoadingMore) return;

    try {
      setState(() => _isLoadingMore = true);
      await invoiceService.fetchUserInvoices(
        context,
        userId,
        limit: _limit,
        offset: _offset,
      );
      setState(() {
        _offset += _limit;
        if (invoiceService.invoices.length >= invoiceService.totalInvoices) {
          _hasReachedEnd = true;
        }
      });
    } catch (e) {
      logger.e('Error loading invoices: $e');
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  Future<void> _loadInvoicesWithFilter() async {
    final now = DateTime.now();
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!).inMilliseconds < 300) {
      return;
    }
    _lastLoadTime = now;

    final invoiceService = Provider.of<InvoiceService>(context, listen: false);
    try {
      setState(() => _isLoadingMore = true);
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
      setState(() {
        _offset += _limit;
        if (invoiceService.invoices.length >= invoiceService.totalInvoices) {
          _hasReachedEnd = true;
        }
      });
    } catch (e) {
      logger.e('Error loading filtered invoices: $e');
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        !_hasReachedEnd) {
      if (_isFilterApplied) {
        _loadInvoicesWithFilter();
      } else {
        _loadInvoices();
      }
    }
  }

  void _toggleViewMode() => setState(() => _isGridView = !_isGridView);
  void _toggleFilterOptions() =>
      setState(() => _showFilterOptions = !_showFilterOptions);

  Widget _buildDatePickerButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      icon: Icon(
        Icons.date_range,
        color: AppColors.iconColor(context),
        size: 16,
      ),
      label: Text(
        label,
        style: TextStyle(color: AppColors.iconColor(context), fontSize: 12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.borderColor(context)),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  Widget _buildFooterWidget() {
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
            'Toutes les factures sont chargées.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textColor(context).withOpacity(0.7),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        rightAction: QuickSettingsWidget(),
        title: S.of(context).adminIceLabel,
      ),
      body: Column(
        children: [
          // Barre des filtres et options
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
                // Ligne principale avec boutons
                Row(
                  children: [
                    // Bouton Filtres
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.filter_list,
                          color: AppColors.buttonTextColor,
                          size: 20,
                        ),
                        label: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _isFilterApplied
                                    ? 'Filtre actif'
                                    : 'Filtrer par date',
                                style: TextStyle(
                                  color: AppColors.buttonTextColor,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              _showFilterOptions
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: AppColors.buttonTextColor,
                              size: 20,
                            ),
                          ],
                        ),
                        onPressed: _toggleFilterOptions,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _isFilterApplied
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
                    ),
                    SizedBox(width: 10),
                    // Bouton reset filtres
                    if (_isFilterApplied)
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: AppColors.iconColor(context),
                        ),
                        onPressed: _resetFilters,
                        tooltip: 'Effacer le filtre',
                        padding: EdgeInsets.all(8),
                        constraints: BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                      ),
                    // Bouton toggle liste/grille
                    IconButton(
                      icon: Icon(
                        _isGridView ? Icons.view_list : Icons.grid_view,
                        color: AppColors.iconColor(context),
                      ),
                      onPressed: _toggleViewMode,
                      tooltip:
                          _isGridView
                              ? 'Afficher en liste'
                              : 'Afficher en grille',
                      padding: EdgeInsets.all(8),
                      constraints: BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                  ],
                ),
                if ((_startDate != null || _endDate != null) &&
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
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 14,
                          color: AppColors.iconColor(context).withAlpha(180),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Date: ${_startDate != null ? "Du ${DateFormat('dd/MM/yyyy').format(_startDate!)}" : ""}'
                            '${_endDate != null ? " Au ${DateFormat('dd/MM/yyyy').format(_endDate!)}" : ""}',
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

                // Options de filtre conditionnelles
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
                        // Sélecteurs de dates
                        Row(
                          children: [
                            Expanded(
                              child: _buildDatePickerButton(
                                label:
                                    _startDate != null
                                        ? 'Du: ${DateFormat('dd/MM/yyyy').format(_startDate!)}'
                                        : 'Date Début',
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
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: _buildDatePickerButton(
                                label:
                                    _endDate != null
                                        ? 'Au: ${DateFormat('dd/MM/yyyy').format(_endDate!)}'
                                        : 'Date Fin',
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
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Bouton Appliquer
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _applyDateFilter,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor(context),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Appliquer',
                              style: TextStyle(
                                color: AppColors.buttonTextColor,
                              ),
                            ),
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
              child: Consumer<InvoiceService>(
                builder:
                    (context, invoiceService, _) => Text(
                      '${invoiceService.totalInvoices} facture${invoiceService.totalInvoices > 1 ? 's' : ''} trouvée${invoiceService.totalInvoices > 1 ? 's' : ''}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textColor(context).withOpacity(0.7),
                      ),
                    ),
              ),
            ),
          ),

          // Contenu principal
          Expanded(
            child: Selector<InvoiceService, List<Invoice>>(
              selector: (_, invoiceService) => invoiceService.invoices,
              builder: (context, invoices, child) {
                final invoiceService = Provider.of<InvoiceService>(
                  context,
                  listen: false,
                );
                return RefreshIndicator(
                  onRefresh: () async {
                    invoiceService.resetState();
                    setState(() {
                      _offset = 0;
                      _hasReachedEnd = false;
                      _isFilterApplied = false;
                    });
                    await _loadInvoices();
                  },
                  child: Builder(
                    builder: (_) {
                      if (invoiceService.isLoading && _offset == 0) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor(context),
                          ),
                        );
                      }

                      if (invoiceService.error != null) {
                        return Center(
                          child: Text(
                            S.of(context).errorMessage(invoiceService.error!),
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.errorColor,
                            ),
                          ),
                        );
                      }

                      if (invoices.isEmpty) {
                        return Center(
                          child: Text(
                            'Aucune facture trouvée.',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.textColor(context),
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: CustomScrollbar(
                          controller: _scrollController,
                          child: CustomScrollView(
                            controller: _scrollController,
                            slivers: [
                              _isGridView
                                  ? SliverGrid(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 16,
                                          childAspectRatio: 0.8,
                                        ),
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) =>
                                          InvoiceCard(invoice: invoices[index]),
                                      childCount: invoices.length,
                                    ),
                                  )
                                  : SliverList(
                                    delegate: SliverChildBuilderDelegate((
                                      context,
                                      index,
                                    ) {
                                      return InvoiceListItemWidget(
                                        invoice: invoices[index],
                                      );
                                    }, childCount: invoices.length),
                                  ),
                              SliverToBoxAdapter(child: _buildFooterWidget()),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}

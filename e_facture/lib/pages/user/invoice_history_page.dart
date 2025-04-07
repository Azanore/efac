import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/widgets/app_bar_widget.dart';
import 'package:e_facture/widgets/custom_card_widget.dart';
import 'package:e_facture/widgets/custom_list_item_widget.dart';
import 'package:e_facture/widgets/custom_scrollbar_widget.dart';
import 'package:e_facture/pages/settings/quick_settings_widget.dart';
import 'package:e_facture/viewmodels/user/user_invoices_view_model.dart';

class UserInvoicesPage extends StatelessWidget {
  const UserInvoicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final viewModel = UserInvoicesViewModel(
          invoiceService: Provider.of(context, listen: false),
          authProvider: Provider.of(context, listen: false),
        );

        // Schedule init() to run after the current build completes
        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewModel.init(context);
        });

        return viewModel;
      },
      builder: (context, _) {
        final vm =
            context
                .watch<
                  UserInvoicesViewModel
                >(); // Scroll infini (ajouté dans la vue car le ViewModel ne peut pas utiliser context)
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (vm.scrollController.hasClients) {
            vm.scrollController.addListener(() {
              if (vm.scrollController.position.pixels >=
                      vm.scrollController.position.maxScrollExtent - 200 &&
                  !vm.isLoadingMore &&
                  !vm.hasReachedEnd) {
                if (vm.isFilterApplied) {
                  vm.loadInvoicesWithFilter(context);
                } else {
                  vm.loadInvoices(context);
                }
              }
            });
          }
        });

        return Scaffold(
          appBar: AppBarWidget(
            rightAction: QuickSettingsWidget(),
            title: S.of(context).userInvoicesTitle,
          ),
          body: Column(
            children: [
              _buildFilterBar(context, vm),
              _buildInvoiceCount(context, vm),
              _buildInvoiceList(context, vm),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterBar(BuildContext context, UserInvoicesViewModel vm) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardColor(context),
        boxShadow: [
          BoxShadow(
            color: AppColors.backgroundColor(
              context,
            ).withAlpha((255 * 0.05).toInt()),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Bouton filtre
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
                          vm.isFilterApplied
                              ? S.of(context).activeFilter
                              : S.of(context).filterByDate,
                          style: TextStyle(
                            color: AppColors.buttonTextColor,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        vm.showFilterOptions
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.buttonTextColor,
                        size: 20,
                      ),
                    ],
                  ),
                  onPressed: vm.toggleFilterOptions,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        vm.isFilterApplied
                            ? AppColors.primaryColor(context)
                            : AppColors.buttonColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (vm.isFilterApplied)
                IconButton(
                  icon: Icon(Icons.clear, color: AppColors.iconColor(context)),
                  onPressed: () => vm.resetFilters(context),
                  tooltip: S.of(context).clearFilterTooltip,
                ),
              IconButton(
                icon: Icon(
                  vm.isGridView ? Icons.view_list : Icons.grid_view,
                  color: AppColors.iconColor(context),
                ),
                onPressed: vm.toggleViewMode,
                tooltip:
                    vm.isGridView
                        ? S.of(context).showListView
                        : S.of(context).showGridView,
              ),
            ],
          ),
          if ((vm.startDate != null || vm.endDate != null) &&
              !vm.showFilterOptions)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    size: 14,
                    color: AppColors.iconColor(context).withAlpha(180),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${S.of(context).dateRangeText} '
                      '${vm.startDate != null ? S.of(context).fromDateLabel(DateFormat('dd/MM/yyyy').format(vm.startDate!)) : ''} '
                      '${vm.endDate != null ? S.of(context).toDateLabel(DateFormat('dd/MM/yyyy').format(vm.endDate!)) : ''}',
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
          if (vm.showFilterOptions)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildDatePickerButton(
                          context,
                          label:
                              vm.startDate != null
                                  ? S
                                      .of(context)
                                      .fromDateLabel(
                                        DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(vm.startDate!),
                                      )
                                  : S.of(context).startDatePlaceholder,
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: vm.startDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) vm.setStartDate(picked);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildDatePickerButton(
                          context,
                          label:
                              vm.endDate != null
                                  ? S
                                      .of(context)
                                      .toDateLabel(
                                        DateFormat(
                                          'dd/MM/yyyy',
                                        ).format(vm.endDate!),
                                      )
                                  : S.of(context).endDatePlaceholder,
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: vm.endDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) vm.setEndDate(picked);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => vm.applyDateFilter(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor(context),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        S.of(context).applyFilter,
                        style: TextStyle(color: AppColors.buttonTextColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDatePickerButton(
    BuildContext context, {
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
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
    );
  }

  Widget _buildInvoiceCount(BuildContext context, UserInvoicesViewModel vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          S.of(context).invoicesFoundCount(vm.totalInvoices),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: AppColors.textColor(context).withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Widget _buildInvoiceList(BuildContext context, UserInvoicesViewModel vm) {
    if (vm.isLoading && vm.invoices.isEmpty) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    if (vm.error != null) {
      return Expanded(
        child: Center(
          child: Text(
            S.of(context).errorPrefix(vm.error!),
            style: TextStyle(fontSize: 18, color: AppColors.errorColor),
          ),
        ),
      );
    }

    if (vm.invoices.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            S.of(context).noInvoicesFound,
            style: TextStyle(fontSize: 18, color: AppColors.textColor(context)),
          ),
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => vm.refresh(context),
        child: CustomScrollbar(
          controller: vm.scrollController,
          slivers: [
            if (vm.isGridView)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: vm.invoices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemBuilder:
                    (_, index) => InvoiceCard(invoice: vm.invoices[index]),
              )
            else
              ...vm.invoices.map(
                (invoice) => InvoiceListItemWidget(invoice: invoice),
              ),
            _buildFooterWidget(context, vm),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterWidget(BuildContext context, UserInvoicesViewModel vm) {
    if (vm.isLoadingMore) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: CircularProgressIndicator(),
        ),
      );
    } else if (vm.hasReachedEnd) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Text(
            S.of(context).allInvoicesLoaded,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textColor(context).withOpacity(0.7),
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

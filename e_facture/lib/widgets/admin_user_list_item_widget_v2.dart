import 'package:flutter/material.dart';
import '/core/services/admin_user_service.dart';
import 'package:e_facture/widgets/invoice_item_styles.dart';
import '/widgets/custom_button_widget.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/generated/l10n.dart';

class AdminUserListItemWidgetV2 extends StatefulWidget {
  final AdminUser user;
  final VoidCallback onToggleStatus;
  final VoidCallback onViewInvoices;
  final bool expandAll;

  const AdminUserListItemWidgetV2({
    super.key,
    required this.user,
    required this.onToggleStatus,
    required this.onViewInvoices,
    required this.expandAll,
  });

  @override
  State<AdminUserListItemWidgetV2> createState() =>
      _AdminUserListItemWidgetV2State();
}

class _AdminUserListItemWidgetV2State extends State<AdminUserListItemWidgetV2> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expandAll;
  }

  @override
  void didUpdateWidget(covariant AdminUserListItemWidgetV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expandAll != widget.expandAll) {
      setState(() {
        _isExpanded = widget.expandAll;
      });
    }
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerColor = AppColors.primaryColor(context);
    final textColor = AppColors.textColor(context);
    final iconColor = AppColors.iconColor(context);
    final cardColor = AppColors.cardColor(context);

    return Container(
      margin: InvoiceItemStyles.containerMargin,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(InvoiceItemStyles.borderRadius),
        boxShadow: [InvoiceItemStyles.boxShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _toggleExpand,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(InvoiceItemStyles.borderRadius),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(InvoiceItemStyles.borderRadius),
                ),
              ),
              padding: InvoiceItemStyles.headerPadding,
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: InvoiceItemStyles.iconSize,
                  ),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.user.legalName,
                      style: TextStyle(
                        fontSize: InvoiceItemStyles.fileNameFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.user.isActive ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.user.isActive
                          ? S.of(context).activeStatus
                          : S.of(context).inactiveStatus,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: InvoiceItemStyles.contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    Icons.business,
                    S.of(context).iceLabel,
                    widget.user.ice,
                    iconColor,
                    textColor,
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.email,
                    S.of(context).emailLabel,
                    widget.user.email,
                    iconColor,
                    textColor,
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.receipt_long,
                    S.of(context).invoicesLabel,
                    '${widget.user.totalInvoices}',
                    iconColor,
                    textColor,
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.attach_money,
                    S.of(context).totalAmountLabel,
                    '${widget.user.totalAmount.toStringAsFixed(2)} MAD',
                    iconColor,
                    textColor,
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButtonWidget(
                        text:
                            widget.user.isActive
                                ? S.of(context).deactivate
                                : S.of(context).activate,
                        height: 36,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        backgroundColor:
                            widget.user.isActive ? Colors.red : Colors.green,
                        onPressed: widget.onToggleStatus,
                      ),
                      CustomButtonWidget(
                        text: S.of(context).viewInvoices,
                        icon: Icons.receipt_long,
                        height: 36,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        onPressed: widget.onViewInvoices,
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value,
    Color iconColor,
    Color textColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: InvoiceItemStyles.iconSize, color: iconColor),
        SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: InvoiceItemStyles.labelFontSize,
                  color: textColor.withOpacity(0.7),
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: InvoiceItemStyles.amountFontSize,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

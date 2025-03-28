import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/core/models/admin_invoice.dart';
import '/core/utils/app_colors.dart';
import '/widgets/invoice_item_styles.dart';
import '/core/utils/admin_invoice_utils.dart';

class AdminInvoiceListItemWidget extends StatefulWidget {
  final AdminInvoice adminInvoice;
  final bool expandAll;

  const AdminInvoiceListItemWidget({
    super.key,
    required this.adminInvoice,
    required this.expandAll,
  });

  @override
  State<AdminInvoiceListItemWidget> createState() =>
      _AdminInvoiceListItemWidgetState();
}

class _AdminInvoiceListItemWidgetState
    extends State<AdminInvoiceListItemWidget> {
  bool _isExpanded = false;
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.expandAll;
  }

  @override
  void didUpdateWidget(covariant AdminInvoiceListItemWidget oldWidget) {
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

  void _startDownload() {
    AdminInvoiceUtils.handleDownloadForAdmin(
      context: context,
      adminInvoice: widget.adminInvoice,
      onStart: () {
        setState(() {
          _isDownloading = true;
          _downloadProgress = 0.0;
        });
      },
      onProgress: (progress) {
        setState(() {
          _downloadProgress = progress;
        });
      },
      onComplete: (message, success, path) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor:
                  success ? AppColors.successColor : AppColors.errorColor,
              duration: const Duration(seconds: 3),
            ),
          );
        }

        setState(() {
          _isDownloading = false;
        });
      },
    );
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
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(InvoiceItemStyles.borderRadius),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: _toggleExpand,
                    child: Padding(
                      padding: InvoiceItemStyles.headerPadding,
                      child: Row(
                        children: [
                          Icon(
                            Icons.receipt_long,
                            color: Colors.white,
                            size: InvoiceItemStyles.iconSize,
                          ),
                          SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.adminInvoice.invoice.fileName,
                              style: TextStyle(
                                fontSize: InvoiceItemStyles.fileNameFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: BorderDirectional(
                      start: BorderSide(color: Colors.white24, width: 0.5),
                    ),
                  ),
                  child: InkWell(
                    onTap: _isDownloading ? null : _startDownload,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(InvoiceItemStyles.borderRadius),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child:
                          _isDownloading
                              ? SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  value: _downloadProgress,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                              : Icon(
                                Icons.download_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: InvoiceItemStyles.contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    Icons.calendar_today,
                    'Date',
                    DateFormat(
                      'dd/MM/yyyy',
                    ).format(widget.adminInvoice.invoice.createdAt),
                    iconColor,
                    textColor,
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.attach_money,
                    'Montant',
                    '${widget.adminInvoice.invoice.amount.toStringAsFixed(2)} MAD',
                    iconColor,
                    textColor,
                  ),
                  SizedBox(height: 8),
                  if (widget.adminInvoice.userLegalName != null)
                    _buildInfoRow(
                      Icons.business,
                      'Société',
                      widget.adminInvoice.userLegalName!,
                      iconColor,
                      textColor,
                    ),
                  if (widget.adminInvoice.userIce != null) ...[
                    SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.confirmation_number,
                      'ICE',
                      widget.adminInvoice.userIce!,
                      iconColor,
                      textColor,
                    ),
                  ],
                  if (widget.adminInvoice.userEmail != null) ...[
                    SizedBox(height: 8),
                    _buildInfoRow(
                      Icons.email,
                      'Email',
                      widget.adminInvoice.userEmail!,
                      iconColor,
                      textColor,
                    ),
                  ],
                  SizedBox(height: 12),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
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
      ),
    );
  }
}

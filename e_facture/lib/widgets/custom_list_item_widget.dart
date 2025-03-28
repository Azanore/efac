import 'package:flutter/material.dart';
import 'package:e_facture/core/models/invoice.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/utils/invoice_utils.dart';
import 'package:e_facture/widgets/invoice_item_styles.dart';

class InvoiceListItemWidget extends StatefulWidget {
  final Invoice invoice;
  const InvoiceListItemWidget({super.key, required this.invoice});

  @override
  State<InvoiceListItemWidget> createState() => _InvoiceListItemWidgetState();
}

class _InvoiceListItemWidgetState extends State<InvoiceListItemWidget> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;

  void _startDownload() {
    InvoiceUtils.handleDownload(
      context: context,
      invoice: widget.invoice,
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor:
                success ? AppColors.successColor : AppColors.errorColor,
          ),
        );
        setState(() {
          _isDownloading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardColor = AppColors.cardColor(context);
    final headerColor = AppColors.primaryColor(context);
    final iconColor = AppColors.iconColor(context);
    final textColor = AppColors.textColor(context);

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
                            widget.invoice.fileName,
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
          Padding(
            padding: InvoiceItemStyles.contentPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: InvoiceItemStyles.iconSize,
                        color: iconColor,
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).invoiceAmount,
                              style: TextStyle(
                                fontSize: InvoiceItemStyles.labelFontSize,
                                color: textColor.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              InvoiceUtils.formatAmount(
                                widget.invoice.amount.toDouble(),
                              ),
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
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: InvoiceItemStyles.iconSize,
                        color: iconColor,
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).invoiceDate,
                              style: TextStyle(
                                fontSize: InvoiceItemStyles.labelFontSize,
                                color: textColor.withOpacity(0.7),
                              ),
                            ),
                            Text(
                              InvoiceUtils.formatDate(widget.invoice.createdAt),
                              style: TextStyle(
                                fontSize: 13,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

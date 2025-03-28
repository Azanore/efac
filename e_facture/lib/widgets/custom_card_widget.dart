import 'package:flutter/material.dart';
import 'package:e_facture/core/models/invoice.dart';
import 'package:e_facture/core/utils/app_colors.dart';
import 'package:e_facture/generated/l10n.dart';
import 'package:e_facture/core/utils/invoice_utils.dart';
import 'package:e_facture/widgets/invoice_item_styles.dart';

class InvoiceCard extends StatefulWidget {
  final Invoice invoice;

  const InvoiceCard({super.key, required this.invoice});

  @override
  _InvoiceCardState createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
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
            duration: Duration(seconds: 3),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(InvoiceItemStyles.borderRadius),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: InvoiceItemStyles.headerPadding,
              color: headerColor,
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
            // Content
            Padding(
              padding: InvoiceItemStyles.contentPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    Icons.attach_money,
                    S.of(context).invoiceAmount,
                    InvoiceUtils.formatAmount(widget.invoice.amount.toDouble()),
                    iconColor,
                    textColor,
                  ),
                  SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.calendar_today,
                    S.of(context).invoiceDate,
                    InvoiceUtils.formatDate(widget.invoice.createdAt),
                    iconColor,
                    textColor,
                  ),
                ],
              ),
            ),
            // Divider
            Divider(
              color: AppColors.primaryColor(context),
              thickness: 0.5,
              height: 0,
            ),
            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child:
                  _isDownloading
                      ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LinearProgressIndicator(
                            value: _downloadProgress,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.primaryColor(context),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${(_downloadProgress * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              fontSize: 12,
                              color: textColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      )
                      : InkWell(
                        onTap: _isDownloading ? null : _startDownload,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download_rounded,
                                size: 18,
                                color: AppColors.primaryColor(context),
                              ),
                              SizedBox(width: 6),
                              Text(
                                S.of(context).invoiceDownload,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primaryColor(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
            ),
          ],
        ),
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

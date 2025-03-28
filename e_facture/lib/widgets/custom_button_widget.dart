import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // pour le feedback haptique
import 'package:e_facture/core/utils/app_colors.dart';

class CustomButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final double? borderRadius;
  final IconData? icon;
  final double? height;
  final double? width;
  final double? iconSize;
  final bool isLoading;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.textStyle,
    this.borderRadius = 12.0,
    this.icon,
    this.height,
    this.width,
    this.iconSize,
    this.isLoading = false,
  });

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final Color buttonBackground =
        widget.backgroundColor ?? AppColors.buttonColor;
    final Color buttonTextColor = widget.textColor ?? AppColors.buttonTextColor;

    final Size screenSize = MediaQuery.of(context).size;
    final double scaleFactor = screenSize.width / 400;
    final double clampedScale = scaleFactor.clamp(
      0.95,
      1.2,
    ); // taille un peu plus généreuse

    final EdgeInsetsGeometry adaptivePadding =
        widget.padding ??
        EdgeInsets.symmetric(
          vertical: 14.0 * clampedScale,
          horizontal: 24.0 * clampedScale,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Listener(
        onPointerDown: (_) {
          setState(() => _isPressed = true);
          HapticFeedback.lightImpact(); // petit retour haptique
        },
        onPointerUp: (_) => setState(() => _isPressed = false),
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 1.0, end: _isPressed ? 0.96 : 1.0),
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : widget.onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBackground,
                  foregroundColor: buttonTextColor,
                  padding: adaptivePadding,
                  elevation: _isPressed ? 1 : 4,
                  shadowColor: Colors.black26,
                  textStyle:
                      widget.textStyle ??
                      TextStyle(
                        fontSize: 16 * clampedScale,
                        fontWeight: FontWeight.w600,
                        color: buttonTextColor,
                      ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? 12.0,
                    ),
                  ),
                  fixedSize:
                      widget.width != null
                          ? Size(widget.width!, widget.height ?? 54.0)
                          : null,
                  minimumSize: const Size(96, 52),
                ),
                child:
                    widget.isLoading
                        ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.icon != null)
                              Icon(
                                widget.icon,
                                size: (widget.iconSize ?? 20) * clampedScale,
                                color: buttonTextColor,
                              ),
                            if (widget.icon != null) const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                widget.text,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:
                                    widget.textStyle ??
                                    TextStyle(
                                      fontSize: 16 * clampedScale,
                                      fontWeight: FontWeight.w600,
                                      color: buttonTextColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
              ),
            );
          },
        ),
      ),
    );
  }
}

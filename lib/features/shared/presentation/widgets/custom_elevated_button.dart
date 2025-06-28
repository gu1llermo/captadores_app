import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key, 
    required this.child, 
    this.onPressed,
    this.minimumSize,
    this.padding,
    this.borderRadius,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.visualDensity,
  });
  
  final VoidCallback? onPressed;
  final Widget child;
  final Size? minimumSize;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? colors.primary,
        foregroundColor: foregroundColor ?? colors.onPrimary,
        minimumSize: minimumSize,
        padding: padding,
        elevation: elevation,
        visualDensity: visualDensity ?? VisualDensity.standard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
      ),
      child: child,
    );
  }
}
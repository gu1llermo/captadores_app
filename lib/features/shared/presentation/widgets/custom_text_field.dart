import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final String? helperText;
  final TextCapitalization textCapitalization;
  final bool allowDecimals;
  final String value;
  final int maxDecimals;
  final bool isNumeric;
  final bool showBorder;
  final bool isLoading;
  final double radius;
  final String? prefixText;
  final bool autofocus;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final bool filled;
  final Color fillColor;
  final Color borderColor;
  final bool showEnabledBorder;
  final bool showFocusedBorder;
  final bool showErrorBorder;
  final bool showFocusedErrorBorder;
  final Widget? prefixIcon;
  final bool obscureText;
  final void Function()? onTap;
  final double maxWidth;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.errorMessage,
    this.helperText,
    this.textCapitalization = TextCapitalization.none,
    this.allowDecimals = false,
    String? value,
    this.maxDecimals = 1,
    this.isNumeric = false,
    this.showBorder = false,
    this.isLoading = false,
    this.radius = 12.0,
    this.prefixText,
    this.autofocus = false,
    this.suffixIcon,
    this.focusNode,
    required this.controller,
    this.filled = false,
    this.fillColor = Colors.transparent,
    this.borderColor = Colors.transparent,
    this.showEnabledBorder = false,
    this.showFocusedBorder = false,
    this.showErrorBorder = false,
    this.showFocusedErrorBorder = false,
    this.prefixIcon,
    this.obscureText = false,
    this.onTap,
    this.maxWidth = 300,
  }) : value = value ?? '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // final effectiveController = controller ?? TextEditingController(text: value);
    
    // Asegúrate de que el controller tenga el valor correcto
    // if (controller == null || controller!.text != value) {
    //   // Guardar la posición actual del cursor
    //   final currentPosition = effectiveController.selection;
    //   final oldText = effectiveController.text;
      
    //   // Actualizar el texto
    //   effectiveController.text = value;
      
    //   // Calcular la nueva posición del cursor para mantenerlo donde estaba
    //   if (currentPosition.isValid && oldText != value) {
    //     // Si la posición era válida y el texto cambió, intentar mantener la misma posición
    //     // o ajustarla si el nuevo texto es más corto
    //     final newPosition = currentPosition.baseOffset;
    //     final maxLength = value.length;
        
    //     effectiveController.selection = TextSelection.fromPosition(
    //       TextPosition(offset: newPosition < maxLength ? newPosition : maxLength),
    //     );
    //   }
    // }

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          enabled: !isLoading,
          obscureText: obscureText,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          onTapOutside: (event) {
            focusNode?.unfocus();
          },
          onTap: onTap,
          autofocus: autofocus,
          focusNode: focusNode,
          keyboardType:
              isNumeric
                  ? TextInputType.numberWithOptions(decimal: allowDecimals)
                  : TextInputType.text,
          inputFormatters: [
            if (isNumeric) ...[
              FilteringTextInputFormatter.allow(
                allowDecimals ? RegExp(r'[0-9.]') : RegExp(r'[0-9]'),
              ),
              // Limitar decimales
              TextInputFormatter.withFunction((oldValue, newValue) {
                String text = newValue.text;
                if (text.isEmpty) return newValue;
      
                if (text.contains('.')) {
                  List<String> parts = text.split('.');
                  if (parts.length > 2) {
                    return oldValue;
                  }
                  if (parts.length == 2 && parts[1].length > maxDecimals) {
                    return oldValue;
                  }
                }
                return newValue;
              }),
            ],
          ],
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: theme.textTheme.labelLarge,
            prefixText: prefixText,
            prefixIcon: prefixIcon,
            
            suffixIcon: suffixIcon,
            errorText: errorMessage,
            helperText: helperText,
            hintText: hintText,
            fillColor: fillColor,
            filled: filled,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(color: colors.onSurface.withAlpha(150)),
            // hintStyle: const TextStyle(color: Colors.black54),
            // Configuración del borde
            border:
                showBorder
                    ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                      borderSide: BorderSide(color: borderColor),
                    )
                    : null,
            enabledBorder:
                showEnabledBorder
                    ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                      borderSide: BorderSide(color: borderColor),
                    )
                    : null,
            focusedBorder:
                showFocusedBorder
                    ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                      borderSide: BorderSide(color: colors.primary, width: 2),
                    )
                    : null,
            errorBorder:
                showErrorBorder
                    ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                      borderSide: BorderSide(color: colors.error),
                    )
                    : null,
            focusedErrorBorder:
                showFocusedErrorBorder
                    ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(radius),
                      borderSide: BorderSide(color: colors.error, width: 2),
                    )
                    : null,
          ),
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}

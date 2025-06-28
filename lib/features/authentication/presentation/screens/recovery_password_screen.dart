import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/presentation/widgets/widgets.dart';
import '../providers/recovery_password_provider.dart';


class RecoveryPasswordScreen extends ConsumerWidget {
  const RecoveryPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(recoveryPasswordNotifierProvider);
    final height = MediaQuery.sizeOf(context).height;
    final colors = Theme.of(context).colorScheme;
    ref.listen(recoveryPasswordNotifierProvider.select((state) => state.statusMessage), (
      previous,
      next,
    ) {
      if (next.isNotEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(next, maxLines: 2, overflow: TextOverflow.ellipsis),
            // backgroundColor: colors.errorContainer,
            behavior: SnackBarBehavior.floating,
            // Ajustar la altura para acomodar dos líneas
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
          ),
        );
      }
    });

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recuperar contraseña'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 0.03 * height),
                // Icon(Icons.person, size: 0.19 * height, color: colors.primary),
                Image.asset(
                  'assets/images/undraw_forgot-password_odai.png',
                  width: 0.35 * height,
                  height: 0.35 * height,
                ),
                const SizedBox(height: 20),
                CustomNumericTextField(
                  isNumeric: false,
                  isLoading: state.isLoading,
                  prefixIcon: const Icon(Icons.email, color: Colors.grey,),
                  showFocusedBorder: true,
                  showErrorBorder: true,
                  showFocusedErrorBorder: true,
                  fillColor: colors.primaryContainer,
                  borderColor: colors.outline,
                  radius: 24,
                  value: state.email.value,
                  controller: state.email.controller,
                  labelText: 'Email',
                  onChanged: (value) =>
                      ref.read(recoveryPasswordNotifierProvider.notifier).updateEmailWithDebounce(value),
                  errorMessage:
                      state.email.hasError
                          ? state.email.errorMessage
                          : null,
                ),
                const SizedBox(height: 20),
    
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    onPressed:
                        state.isLoading
                            ? null
                            : () {
                              ref.read(recoveryPasswordNotifierProvider.notifier).recoveryPassword();
                            },
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Recuperar contraseña'),
                  ),
                ),
                const SizedBox(height: 40),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

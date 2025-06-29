import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/rutas.dart';
import '../../../shared/presentation/widgets/widgets.dart';
import '../providers/login_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginNotifierProvider);
    final height = MediaQuery.sizeOf(context).height;
    final colors = Theme.of(context).colorScheme;
    ref.listen(loginNotifierProvider.select((state) => state.errorMessage), (
      previous,
      next,
    ) {
      if (next.isNotEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 5),
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
      // onTap: () => context.hideKeyboard(),
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  
                  children: [
                    SizedBox(height: 0.08 * height),
                    Icon(Icons.person, size: 0.19 * height, color: colors.primary),
                    // Image.asset(
                    //   'assets/images/login_fondo_blanco.webp',
                    //   width: 0.25 * height,
                    //   height: 0.25 * height,
                    // ),
                    const SizedBox(height: 20),
                    CustomNumericTextField(
                      isNumeric: false,
                      isLoading: state.isLoading,
                      prefixIcon: const Icon(Icons.person, color: Colors.grey,),
                      // showBorder: true,
                      // showEnabledBorder: true,
                      showFocusedBorder: true,
                      showErrorBorder: true,
                      showFocusedErrorBorder: true,
                      fillColor: colors.primaryContainer,
                      // filled: true,
                      // borderColor: Colors.transparent,
                      borderColor: colors.outline,
                      radius: 24,
                      value: state.email.value,
                      controller: state.email.controller,
                      labelText: 'Email',
                      onChanged: (value) {
                        ref
                            .read(loginNotifierProvider.notifier)
                            .updateEmailWithDebounce(value);
                      },
                      errorMessage:
                          state.email.hasError
                              ? state.email.errorMessage
                              : null,
                    ),
                    const SizedBox(height: 20),
                    CustomNumericTextField(
                      isNumeric: false,
                      isLoading: state.isLoading,
                      prefixIcon: const Icon(Icons.lock, color: Colors.grey,),
                      suffixIcon:
                          !state.obscureText
                              ? IconButton(
                                onPressed: () {
                                  ref.read(loginNotifierProvider.notifier).toggleObscureText();
                                },
                                icon: const Icon(Icons.visibility),
                              )
                              : IconButton(
                                onPressed: () {
                                  ref.read(loginNotifierProvider.notifier).toggleObscureText();
                                },
                                icon: const Icon(Icons.visibility_off),
                              ),
                      obscureText: state.obscureText,
                      // showBorder: true,
                      // showEnabledBorder: true,
                      showFocusedBorder: true,
                      showErrorBorder: true,
                      showFocusedErrorBorder: true,
                      fillColor: colors.primaryContainer,
                      // filled: true,
                      // borderColor: Colors.transparent,
                      borderColor: colors.outline,
                      radius: 24,
                      value: state.password.value,
                      controller: state.password.controller,
                      labelText: 'Password',
                          
                      onChanged: (value) {
                        ref
                            .read(loginNotifierProvider.notifier)
                            .updatePasswordWithDebounce(value);
                      },
                      errorMessage:
                          state.password.hasError
                              ? state.password.errorMessage
                              : null,
                    ),
                          
                    const SizedBox(height: 40),
                          
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        onPressed:
                            state.isLoading
                                ? null
                                : () {
                                  ref.read(loginNotifierProvider.notifier).login();
                                },
                        child:
                            state.isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Iniciar sesión'),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    const Text('versión 5'),
                    // const SizedBox(height: 40),
                    // TextButton(
                    //   onPressed: () {
                    //     // context.push(Rutas.recoveryPassword);
                    //     context.push('${Rutas.login}/${Rutas.recoveryPassword}');
                    //   },
                    //   child: const Text('Recuperar contraseña'),
                    // ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

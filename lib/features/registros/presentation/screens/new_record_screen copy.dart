import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/presentation/widgets/widgets.dart';
import '../providers/new_record_provider.dart';

class NewRecordScreen extends ConsumerWidget {
  const NewRecordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newRecordAsynState = ref.watch(newRecordNotifierProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text('Nuevo Registro')),
            newRecordAsynState.when(
              data: (state) {
      
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
      
                        Wrap(
                          spacing: 16.0,
                          runSpacing: 8.0,
                          children: [
                            CustomTextField(
                              labelText: 'Nombre Cliente',
                              value: state.nombreCompletoCliente.value,
                              textInputAction: TextInputAction.next,
                              controller: state.nombreCompletoCliente.controller,
                              errorMessage:
                                  state.nombreCompletoCliente.hasError == true
                                  ? state.nombreCompletoCliente.errorMessage
                                  : null,
                            ),
                            CustomTextField(
                              labelText: 'Fono Contacto Cliente',
                              value: state.fonoContactoCliente.value,
                              isNumeric: true,
                              textInputAction: TextInputAction.next,
                              controller: state.fonoContactoCliente.controller,
                              errorMessage:
                                  state.fonoContactoCliente.hasError == true
                                  ? state.fonoContactoCliente.errorMessage
                                  : null,
                            ),
                            CustomTextField(
                              labelText: 'Email Cliente',
                              value: state.emailCliente.value,
                              textInputAction: TextInputAction.next,
                              controller: state.emailCliente.controller,
                            ),
                            CustomTextField(
                              labelText: 'Rut Cliente',
                              value: state.rutCliente.value,
                              textInputAction: TextInputAction.next,
                              controller: state.rutCliente.controller,
                            ),
                            CustomTextField(
                              labelText: 'Dni Ext',
                              value: state.dniExt.value,
                              textInputAction: TextInputAction.next,
                              controller: state.dniExt.controller,
                            ),
                            ComboBoxWidget(
                              title: 'Seleccionar Abogado',
                              items: state.abogados, 
                              controller: state.controllerComboWidget,
                              label: const Text('Abogado que Recepciona'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomElevatedButton(
                              child: const Text('Crear Nuevo Registro'),
                              onPressed: () {
                                ref.read(newRecordNotifierProvider.notifier).onFormSubmit();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              error: (error, stackTrace) {
                return const SliverToBoxAdapter(child: Text('Error'));
              },
              loading: () {
                return const SliverToBoxAdapter(child: Column(
                  children: [
                     SizedBox(height: 50),
                    SizedBox.square(
                      dimension: 30,
                      child: CircularProgressIndicator(strokeWidth: 2)),
                  ],
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

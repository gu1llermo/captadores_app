import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecordDetailsScreen extends ConsumerWidget {
  const RecordDetailsScreen({super.key, required this.idRegistro});
  final String idRegistro;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle Registro')),
      body: Center(child: Text(idRegistro)),
    );
  }
}

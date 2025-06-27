import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/rutas.dart';


class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            const Text('404 - La página que estás buscando no existe'),
            TextButton(
              child: const Text('Volver a home'),
              onPressed: () {
                context.go(Rutas.home);
              },
            ),
          ],
        ),
      ),
    );
  }
}
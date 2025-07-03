import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class StatusMessageWidget extends StatelessWidget {
  const StatusMessageWidget({
    super.key,
    required this.message,
    this.hasError = false,
  });
  final String message;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: FadeInDown(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: hasError ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

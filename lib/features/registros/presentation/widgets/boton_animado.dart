import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BotonAnimado extends StatefulWidget {
  const BotonAnimado({
    super.key,
    required this.scrollController,
    this.onPressed,
    required this.title,
  });
  final ScrollController? scrollController;
  final void Function()? onPressed;
  final String title;

  @override
  State<BotonAnimado> createState() => _BotonAnimadoState();
}

class _BotonAnimadoState extends State<BotonAnimado> {
  //bool isVisible = true;
  ValueNotifier<bool> isVisibleNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(listener);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(listener);
    super.dispose();
  }

  void listener() {
    if (widget.scrollController?.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isVisibleNotifier.value) {
        isVisibleNotifier.value = false;
      }
    } else if (widget.scrollController?.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!isVisibleNotifier.value) {
        isVisibleNotifier.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isVisibleNotifier,
      builder: (context, value, child) {
        return AnimatedSlide(
          offset: value ? Offset.zero : const Offset(0, 2),
          duration: const Duration(milliseconds: 400),
          child: AnimatedOpacity(
            opacity: value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: FloatingActionButton.extended(
              onPressed: widget.onPressed,
              label:  Text(widget.title),
              icon: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}
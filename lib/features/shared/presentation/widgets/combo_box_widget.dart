import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComboBoxWidget extends StatefulWidget {
  final List<String> items;
  // final Function(String) onChanged;
  final TextEditingController controller;
  final Widget? label;
  final double maxWidth;
  final String title;

  const ComboBoxWidget({
    required this.title,
    super.key,
    required this.items,
    required this.controller,
    this.label,
    this.maxWidth = 300.0,
  });

  @override
  State<ComboBoxWidget> createState() => _ComboBoxWidgetState();
}

class _ComboBoxWidgetState extends State<ComboBoxWidget> {
  TextEditingController controller = TextEditingController();
  bool showDropdown = false;
  final focusNode = FocusNode();

  void showListAbogados(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(widget.title, style: textTheme.bodyLarge),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(widget.items[index]),
                      onTap: () {
                        widget.controller.text = widget.items[index];
                        // widget.onChanged(widget.items[index]);
                        focusNode.unfocus();
                        setState(() {
                          showDropdown = false;
                        });
                        context.pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ).then((value) {
      setState(() {
        showDropdown = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: Column(
        children: [
          TextField(
            controller: widget.controller,
            focusNode: focusNode,
            onTapOutside: (event) {
              setState(() {
                showDropdown = false;
              });
            },
            decoration: InputDecoration(
              label: widget.label,
              labelStyle: theme.textTheme.labelLarge,

              suffixIcon: widget.items.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        showDropdown
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onPressed: () {
                        showListAbogados(context);
                        setState(() {
                          showDropdown = !showDropdown;
                        });
                      },
                    )
                  : null,
            ),
            // onChanged: widget.onChanged,
          ),
          // if (showDropdown)
          //   SizedBox(
          //     height: 200,
          //     child: ListView.builder(
          //       itemCount: widget.items.length,
          //       itemBuilder: (context, index) {
          //         return ListTile(
          //           title: Text(widget.items[index]),
          //           onTap: () {
          //             widget.controller.text = widget.items[index];
          //             // widget.onChanged(widget.items[index]);
          //             setState(() {
          //               showDropdown = false;
          //             });
          //           },
          //         );
          //       },
          //     ),
          //   ),
        ],
      ),
    );
  }
}

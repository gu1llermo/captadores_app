import 'package:flutter/material.dart';

import 'product_card_shimmer_widget.dart';

class ProductShimmerList extends StatelessWidget {
  final int itemCount;

  const ProductShimmerList({super.key, this.itemCount = 20});

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.sizeOf(context).width;

    // final crossAxisCount = (width ~/ 360).clamp(1, 20);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      sliver: SliverList.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return const ProductCardShimmerWidget();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';


class ProductCardShimmerWidget extends StatelessWidget {
  const ProductCardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        // final availableWidth = 360.0;

        final imageWidth = 30.0;
        final imageHeight = 30.0;
        // final imageWidth = AppConstants.imageProductWidth;
        // final imageHeight = AppConstants.imageProductHeight;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Card(
            color: colors.surface,
            child: Shimmer(
              
              child: Row(
                children: [
                  // Simulación de la imagen
                  Container(
                    width: imageWidth,
                    height: imageHeight,
                    color: Colors.white,
                  ),
                  //const SizedBox(width: 10),
                  // Simulación del contenido
                  Expanded(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //const SizedBox(height: 10),
                        // Simulación del título
                        Container(
                          width: availableWidth * 0.5,
                          height: 8,
                          color: Colors.white,
                        ),

                        Container(
                          width: availableWidth * 0.4,
                          height: 20,
                          color: Colors.white,
                        ),

                        Container(
                          width: availableWidth * 0.3,
                          height: 10,
                          color: Colors.white,
                        ),
                        Container(
                          width: availableWidth * 0.15,
                          height: 8,
                          color: Colors.white,
                        ),
                        Container(
                          width: availableWidth * 0.5,
                          height: 15,
                          color: Colors.white,
                        ),
                        //const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

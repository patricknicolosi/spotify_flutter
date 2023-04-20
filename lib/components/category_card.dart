import 'package:flutter/material.dart';
import 'package:colorlizer/colorlizer.dart' as colorlizer;

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Function onTap;
  const CategoryCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: colorlizer.ColorLizer().getRandomColors(),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Stack(
          children: [
            Positioned(
              top: 160.0,
              left: 160.0,
              child: RotationTransition(
                turns: const AlwaysStoppedAnimation(25 / 360),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Image.network(
                    imageUrl,
                    width: 120,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

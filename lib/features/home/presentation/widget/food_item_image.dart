import 'package:flutter/material.dart';

import '../../../../core/contents/images.dart';

class FoodItemImage extends StatefulWidget {
  const FoodItemImage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FoodItemImageState createState() => _FoodItemImageState();
}

class _FoodItemImageState extends State<FoodItemImage> {
  bool _isLoved = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            child: Image.asset(
              ImageResources.ordinaryBurgers,
              height: 300,
              fit: BoxFit.cover,
              cacheHeight: 150,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isLoved = !_isLoved;
                });
              },
              child: Icon(
                Icons.favorite,
                color: _isLoved ? Colors.red : Colors.white,
                size: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

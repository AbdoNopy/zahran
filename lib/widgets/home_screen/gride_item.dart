import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;

  const GridItem(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          image:
              DecorationImage(image: AssetImage('assets/images/item_1.png'))),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
          ),
        )),
    );
  }
}

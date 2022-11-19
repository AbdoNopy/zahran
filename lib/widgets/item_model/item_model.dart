import 'package:flutter/material.dart';
import 'dart:io';

class ItemModel extends StatelessWidget {
  const ItemModel(
      {Key? key,
      required this.id,
      required this.imageUrl,
      required this.imageFile,
      required this.title,
      required this.description,
      required this.routeName})
      : super(key: key);
  final int id;
  final String imageUrl;
  final bool imageFile;
  final String title;
  final String description;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    File? _fileImage = File(imageUrl);
    return SafeArea(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName, arguments: id);
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          height: MediaQuery.of(context).size.width * .4,
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8 * .4,
                  height: MediaQuery.of(context).size.width * .4 * .8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                            tag: imageUrl,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            )
                          )
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                        softWrap: true,
                        textDirection: TextDirection.rtl,
                      ),
                      Expanded(
                        child: SizedBox(
                          // height: 50,
                          width: MediaQuery.of(context).size.width * .8 * .6,
                          child: Text(
                            description,
                            style: const TextStyle(fontSize: 12),
                            textAlign: TextAlign.end,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

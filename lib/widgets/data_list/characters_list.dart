import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zahran/screens/Characters/character_details.dart';

import '../../provider/characters_provider.dart';
import '../../screens/Characters/characters.dart';
import '../item_model/item_model.dart';

class CharaListView extends StatelessWidget {
  const CharaListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final charaList = Provider.of<CharactersProvider>(context).currentCatList;
    return SizedBox(
      height: MediaQuery.of(context).size.height*.75,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 15),
        itemCount: charaList.length,
        itemBuilder: (context, i) {
          return  Column(children: [
            const SizedBox(
              height: 10,
            ),
            ItemModel(
              id: charaList[i].id,
              imageUrl: charaList[i].image,
              imageFile: false,
              title: charaList[i].title,
              description: charaList[i].description,
              routeName: CharacterDetailScreen.routeName,
            ),
          ]);
        },
      ),
    );
  }
}

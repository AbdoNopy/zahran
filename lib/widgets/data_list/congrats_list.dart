import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/data_provider/get_data_provider.dart';
import '../../screens/news/news_details.dart';
import '../item_model/item_model.dart';

class CongratsList extends StatelessWidget {
  const CongratsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conData = Provider.of<GetDataProvider>(context);
    final List conList = conData.loadedList;
    return  ListView.builder(
      padding: const EdgeInsets.only(bottom: 15),
      itemCount: conList.length,
      itemBuilder: (context, i) {
        return Column(children: [
          const SizedBox(
            height: 10,
          ),
          ItemModel(
            id: conList[i].id,
            imageUrl: conList[i].image,
            imageFile: false,
            title: conList[i].title,
            description: conList[i].description,
            routeName: NewsDetail.routeName,
          ),
        ]);
      },
    );
  }
}

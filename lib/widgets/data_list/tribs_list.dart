import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/data_provider/get_data_provider.dart';
import '../../screens/news/news_details.dart';
import '../item_model/item_model.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tribsData = Provider.of<GetDataProvider>(context);
    final List tribsList = tribsData.loadedList;
    return  ListView.builder(
      padding: const EdgeInsets.only(bottom: 15),
      itemCount: tribsList.length,
      itemBuilder: (context, i) {
        return Column(children: [
          const SizedBox(
            height: 10,
          ),
          ItemModel(
            id: tribsList[i].id,
            imageUrl: tribsList[i].image,
            imageFile: false,
            title: tribsList[i].title,
            description: tribsList[i].description,
            routeName: NewsDetail.routeName,
          ),
        ]);
      },
    );
  }
}

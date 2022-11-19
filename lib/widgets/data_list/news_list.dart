import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/data_provider/get_data_provider.dart';
import '../../screens/news/news_details.dart';
import '../item_model/item_model.dart';

class NewsListView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final newsData = Provider.of<GetDataProvider>(context);
    final List newsList = newsData.loadedList;
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 15),
      itemCount: newsList.length,
      itemBuilder: (context, i) {
        return Column(children: [
          const SizedBox(
            height: 10,
          ),
          ItemModel(
            id: newsList[i].id,
            imageUrl: newsList[i].image,
            imageFile: false,
            title: newsList[i].title,
            description: newsList[i].description,
            routeName: NewsDetail.routeName,
          ),
        ]);
      },
    );
  }
}

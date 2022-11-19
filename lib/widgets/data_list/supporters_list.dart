import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/data_provider/get_data_provider.dart';
import '../../screens/news/news_details.dart';
import '../item_model/item_model.dart';

class SupportersList extends StatelessWidget {
  const SupportersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final suppData = Provider.of<GetDataProvider>(context);
    final List suppList = suppData.loadedList;
    return  ListView.builder(
      padding: const EdgeInsets.only(bottom: 15),
      itemCount: suppList.length,
      itemBuilder: (context, i) {
        return Column(children: [
          const SizedBox(
            height: 10,
          ),
          ItemModel(
            id: suppList[i].id,
            imageUrl: suppList[i].image,
            imageFile: false,
            title: suppList[i].title,
            description: suppList[i].description,
            routeName: NewsDetail.routeName,
          ),
        ]);
      },
    );
  }
}

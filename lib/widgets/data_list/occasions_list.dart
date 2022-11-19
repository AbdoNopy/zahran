import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zahran/provider/data_provider/get_data_provider.dart';
import '../../screens/occasions/occasions_details.dart';
import '../item_model/item_model.dart';

class OccListView extends StatelessWidget {
  const OccListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final occData = Provider.of<GetDataProvider>(context);
    final List occasionsList = occData.loadedList;
    return  ListView.builder(
      padding: const EdgeInsets.only(bottom: 15),
      itemCount: occasionsList.length,
      itemBuilder: (context, i) {
        return Column(children: [
          const SizedBox(
            height: 10,
          ),
          ItemModel(
            id: occasionsList[i].id,
            imageUrl: occasionsList[i].image,
            imageFile: false,
            title: occasionsList[i].title,
            description: occasionsList[i].description,
            routeName: OccasionsDetails.routeName,
          )
        ]);
      },
    );
  }
}

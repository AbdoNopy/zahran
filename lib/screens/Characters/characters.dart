import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zahran/provider/characters_provider.dart';

import '../../app_assets/colors.dart';
import '../../widgets/data_list/characters_list.dart';

class CharactersScreen extends StatefulWidget {
  CharactersScreen({Key? key}) : super(key: key);
  static const String routeName = '/Characters Screen';

  @override
  State<CharactersScreen> createState() => _CharactersScreen();
}

class _CharactersScreen extends State<CharactersScreen> {
  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context)!.settings.arguments as String;
    final charaData = Provider.of<CharactersProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(.9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .15,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: charaData.getCatData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else {
                    return CatItemList();
                  }
                },
              ),
              FutureBuilder(
                future: charaData.getCharData(CatItemList().currentCat),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }else {
                    return Provider.of<CharactersProvider>(context)
                            .currentCatList
                            .isEmpty
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * .7,
                            child: const Center(
                                child: Text(
                              'لا توجد بيانات',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                          )
                        : const CharaListView();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CatItemList extends StatefulWidget {
  CatItemList({Key? key}) : super(key: key);
  int currentCat = 4;

  @override
  State<CatItemList> createState() => _CatItemListState();
}

class _CatItemListState extends State<CatItemList> {

  @override
  Widget build(BuildContext context) {
    final catList = Provider.of<CharactersProvider>(context).categoryList;
    final charaData = Provider.of<CharactersProvider>(context);
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width * .9,
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
        itemCount: catList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  overlayColor:
                      MaterialStateColor.resolveWith((states) => AppColors.primaryColor),
                ),
                onPressed: () {
                  setState(() {
                    widget.currentCat = catList[index].id;
                  });
                  charaData.getCharData(widget.currentCat);
                },
                child: Text(
                  catList[index].name,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                )),
          );
          //   InkWell(
          //   splashColor: Colors.red,
          //   onTap: () {
          //     setState(() {
          //       widget.currentCat = catList[index].id;
          //
          //     });
          //     charaData.getCharData(widget.currentCat);
          //   },
          //   child:
          //
          //   // Container(
          //   //   padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
          //   //   margin: const EdgeInsets.only(left: 10),
          //   //   decoration:  BoxDecoration(
          //   //       borderRadius: const BorderRadius.all(Radius.circular(10)),
          //   //       color: Colors.white,
          //   //   ),
          //   //   child:
          //   //   Text(
          //   //     catList[index].name,
          //   //     overflow: TextOverflow.visible,
          //   //     textAlign: TextAlign.center,
          //   //   ),
          //   // ),
          // );
        },
      ),
    );
  }
}

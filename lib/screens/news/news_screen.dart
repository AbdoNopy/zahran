import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zahran/app_assets/colors.dart';
import 'package:zahran/provider/data_provider/get_data_provider.dart';
import 'package:zahran/screens/news/add_news.dart';

import '../../widgets/data_list/news_list.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);
  static const String routeName = '/News Screen';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context)!.settings.arguments as String;
    final newsData = Provider.of<GetDataProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(.9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
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
                Align(
                  heightFactor: MediaQuery.of(context).size.height * .0032,
                  alignment: Alignment.bottomLeft,
                  child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: Colors.brown.withOpacity(.9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 3)),
                      child: IconButton(
                          onPressed: () {
                            newsData.getTerms();
                            Navigator.pushNamed(
                                context, AddNewsScreen.routeName);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.white,
                          ))),
                ),
              ]),
              FutureBuilder(
                future: newsData.getNews(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * .8,
                          width: MediaQuery.of(context).size.width,
                          child:  NewsListView()
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

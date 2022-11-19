import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zahran/app_assets/colors.dart';
import 'package:zahran/provider/characters_provider.dart';
import 'package:zahran/provider/data_provider/add_data_provider.dart';
import 'package:zahran/screens/Characters/characters.dart';
import 'package:zahran/screens/congrats/add_congrats_screen.dart';
import 'package:zahran/screens/congrats/congrats_screen.dart';
import 'package:zahran/screens/occasions/add_occ.dart';
import 'package:zahran/screens/occasions/occasions_details.dart';
import 'package:zahran/screens/Characters/character_details.dart';
import 'package:zahran/screens/supporters/supporters_screen.dart';
import 'package:zahran/screens/tribal_elders/tribal_elders.dart';

import './provider/data_provider/get_data_provider.dart';
import './screens/home_screen.dart';
import './screens/news/add_news.dart';
import './screens/news/news_details.dart';
import './screens/news/news_screen.dart';
import './screens/occasions/occasions_screen.dart';
import './splash/splash_screen.dart';
import '../provider/home_provider.dart';

void main() {
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BannerImage()),
        ChangeNotifierProvider(create: (_) => GetDataProvider()),
        ChangeNotifierProvider(create: (_) => CharactersProvider()),
        ChangeNotifierProvider(create: (_) => AddDataProvider()),
      ],
      child: MaterialApp(
        color: AppColors.primaryColor,
        debugShowCheckedModeBanner: false,
        title: 'Zahran App',
        home: const SplashScreen(),
        routes: RoutesData().routes,
      ),
    );
  }
}

class RoutesData {
  Map<String, Widget Function(BuildContext)> routes = {
    HomeScreen.routeName: (ctx) => const HomeScreen(),
    NewsScreen.routeName: (ctx) => const NewsScreen(),
    NewsDetail.routeName: (ctx) => const NewsDetail(),
    AddNewsScreen.routeName: (ctx) => AddNewsScreen(),
    OccasionsScreen.routeName: (ctx) => const OccasionsScreen(),
    OccasionsDetails.routeName: (ctx) => const OccasionsDetails(),
    AddOccScreen.routeName: (ctx) => AddOccScreen(),
    CongratsScreen.routeName: (cts) => const CongratsScreen(),
    AddCongratsScreen.routeName: (ctx) => AddCongratsScreen(),
    EldersScreen.routeName: (ctx) => const EldersScreen(),
    CharactersScreen.routeName: (ctx) => CharactersScreen(),
    CharacterDetailScreen.routeName: (ctx) => const CharacterDetailScreen(),
    SupportersScreen.routeName: (ctx) => const SupportersScreen(),
  };
}

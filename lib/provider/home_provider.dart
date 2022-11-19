import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zahran/screens/Characters/characters.dart';
import 'package:zahran/screens/congrats/congrats_screen.dart';
import 'package:zahran/screens/news/news_screen.dart';
import 'package:zahran/screens/supporters/supporters_screen.dart';
import 'package:zahran/screens/tribal_elders/tribal_elders.dart';
import 'dart:convert';
import '../app_assets/urls.dart';
import '../screens/occasions/occasions_screen.dart';

class BannerImage with ChangeNotifier {
  List<Map<String, dynamic>> gridData = [
    {'title': "الاخبار", 'routeName': NewsScreen.routeName},
    {'title': "المناسبات", 'routeName': OccasionsScreen.routeName},
    {'title': "شيوخ القبائل", 'routeName': EldersScreen.routeName},
    {'title': "تاريخ زهران", 'routeName': NewsScreen.routeName},
    {'title': "التهنئات", 'routeName': CongratsScreen.routeName},
    {'title': "شخصيات ورموز", 'routeName': CharactersScreen.routeName},
    {'title': "الداعمون", 'routeName': SupportersScreen.routeName},
    {'title': "خدمات وعروض", 'routeName': NewsScreen.routeName},
  ];


  String? _imageUrl;

  Future<void> getImageUrl() async {
    try {
      final Uri url = Uri.parse('${URLs.mainUrl}/banners');
      final response = await http.get(url);
      if(response.statusCode <= 200) {
        final responseData = await json.decode(response.body) as Map<String, dynamic>;
        _imageUrl = responseData['data'][0]['img'];
        notifyListeners();
      }

    } catch (e) {
      print(e);
      rethrow;
    }
  }

  String? get imageUrl {
    return _imageUrl;
  }
}

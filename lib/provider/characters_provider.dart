import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zahran/app_assets/urls.dart';
import 'package:http/http.dart' as http;

import 'data_provider/data_model.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});
}

class CharacterModel {
  final int id;
  final String name;
  final String desc;
  final String imgUrl;
  final String job;

  CharacterModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.imgUrl,
    required this.job,
  });
}

class CharactersProvider with ChangeNotifier {
  List<CategoryModel> _category = [];
  List<DataModel> _currentCategory = [];

  List<CategoryModel> get categoryList {
    return [..._category];
  }

  List get currentCatList {
    return [..._currentCategory];
  }

  Future<void> getCatData() async {
    final Uri url = Uri.parse('${URLs.mainUrl}/categories-symbol');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body)['data'] as List;
      final List<CategoryModel> categoryList = [];
      responseData.forEach((element) {
        categoryList.add(CategoryModel(
          id: element['id'],
          name: element['name'],
        ));
      });
      _category = categoryList;
      notifyListeners();
      if (response.statusCode == 200) {
        print('cat loaded');
      } else {
        print('no');
      }
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }

  Future<void> getCharData(int catId) async {
    final Uri url = Uri.parse('${URLs.mainUrl}/symbolies');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body)['data']['data'] as List;

      // List currentCatList =  responseData
      //     .where((element) => element['category_id'] == catId)
      //     .toList();
      List currentCatList = responseData
          .where((element) => element['category_id'] == catId)
          .toList();
      List<DataModel> newCurrentCatList = [];
      currentCatList.forEach((element) {
        newCurrentCatList.add(DataModel(
            id: element['id'],
            title: element['name'],
            description: element['desc'],
            image: element['img'],
            url: 'url',
            date: DateTime.now().toIso8601String()));
      });

      _currentCategory = newCurrentCatList;
      notifyListeners();
      if (response.statusCode == 200) {
        print('list loaded');
      } else {
        print('no');
      }
    } catch (e) {
      print('error $e');
      rethrow;
    }
  }

  DataModel findById(int id) {
    return _currentCategory.firstWhere((element) => element.id == id);
  }
}

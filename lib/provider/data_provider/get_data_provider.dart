import 'dart:io';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:zahran/app_assets/urls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zahran/provider/data_provider/data_model.dart';

class GetDataProvider with ChangeNotifier {
  List<DataModel> _dataList = [];
  Map _termsData = {};

  List<DataModel> get loadedList {
    return [..._dataList];
  }

  Map get termsData {
    return _termsData;
  }

  Future<void> getData(String dataUrl) async {
    try {
      final Uri url = Uri.parse('${URLs.mainUrl}$dataUrl');
      final response = await http.get(url);
      final responseData = json.decode(response.body)["data"]["data"];
      final List<DataModel> listData = [];
      responseData.forEach((element) {
        listData.add(DataModel(
            id: element['id'],
            title: element['title'],
            description: element['desc'],
            image: element['img'],
            url: 'element[' ']',
            date: element['publish_date']));
      });
      _dataList = listData;
      notifyListeners();
      if (response.statusCode == 200) {
        // print('ok');
      } else {
        // print(response.statusCode);
      }
    } on SocketException {
      // print('1');
    } on FormatException {
      // print('2');
    } catch (e) {
      // print('error $e');
      rethrow;
    }
  }

  Future<void> getNews() async {
    await getData('/news');
  }

  Future<void> getOcc() async {
    await getData('/occasions');
  }

  Future<void> getCongrats() async {
    await getData('/congratulations');
  }

  Future<void> getTribal() async {
    try {
      final Uri url = Uri.parse('${URLs.mainUrl}/tribs');
      final response = await http.get(url);
      final responseData = json.decode(response.body)["data"];
      final List<DataModel> listData = [];
      responseData.forEach((element) {
        listData.add(DataModel(
            id: element['id'],
            title: element['name'],
            description: element['desc'],
            image: element['img'],
            url: 'element[' ']',
            date: element['date']));
      });
      _dataList = listData;
      notifyListeners();
      if (response.statusCode == 200) {
        // print('ok');
      } else {
        // print(response.statusCode);
      }
    } on SocketException {
      // print('1');
    } on FormatException {
      // print('2');
    } catch (e) {
      // print('error $e');
      rethrow;
    }
  }

  Future<void> getSupporters() async {
    try {
      final Uri url = Uri.parse('${URLs.mainUrl}/supporters');
      final response = await http.get(url);
      final responseData = json.decode(response.body)["data"]["data"];
      final List<DataModel> listData = [];
      responseData.forEach((element) {
        listData.add(DataModel(
            id: element['id'],
            title: element['name'],
            description: element['desc'],
            image: element['img'],
            url: 'element[' ']',
            date: element['date']));
      });
      _dataList = listData;
      notifyListeners();
      if (response.statusCode == 200) {
        // print('ok');
      } else {
        // print(response.statusCode);
      }
    } on SocketException {
      // print('1');
    } on FormatException {
      // print('2');
    } catch (e) {
      // print('error $e');
      rethrow;
    }
  }

  Future<void> getTerms() async {
    try {
      final Uri url = Uri.parse('${URLs.mainUrl}/terms');
      final response = await http.get(url);
      final responseData = json.decode(response.body)['data'] as Map;
      // final String termsTitle = responseData['title'];
      // final String termsDesc = responseData['desc'];
      _termsData = responseData;
    } on SocketException {
      // print('1');
    } on FormatException {
      // print('2');
    } catch (e) {
      // print('error $e');
      rethrow;
    }
  }

  DataModel findById(int id) {
    return _dataList.firstWhere((element) => element.id == id);
  }
}

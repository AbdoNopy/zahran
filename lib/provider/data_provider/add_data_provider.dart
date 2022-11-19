import 'package:flutter/cupertino.dart';

import '../../app_assets/urls.dart';
import 'new_news_model.dart';
import 'package:dio/dio.dart';

class AddDataProvider with ChangeNotifier {
  Future<void> addData(news, String createUrl) async {
    final Uri url = Uri.parse('${URLs.mainUrl}/$createUrl');
    var dio = Dio();
    var formData = FormData.fromMap({
      'id': DateTime
          .now()
          .second,
      'title': news.title,
      'name': news.title,
      'mobile': news.mobile,
      'desc': news.desc,
      'img': await MultipartFile.fromFile(news.img.path),
      // 'vedio': newNewsModel.vedio.path,
      'device_key': news.device_key
    });
    var response = await dio.postUri(
      url,
      data: formData,
    );
  }

  Future<void> addNews(NewDataModel news) async {
    await addData(news, 'news/create');
  }

  Future<void> addOcc(NewDataModel occ) async {
    await addData(occ, 'occasions/create');
  }


Future<void> addCong(NewDataModel occ) async {
  await addData(occ, 'congratulations/create');
}}

/// shared prefs
// Future<void> addNews(NewsModel newsModel) async {
//   final prefs = await SharedPreferences.getInstance();
//   final newNews = json.encode({
//     'id': DateTime.now().day,
//     'title': newsModel.title,
//     'description': newsModel.description,
//     'image': newsModel.image,
//     'url': newsModel.url,
//     'date': newsModel.date,
//   });
//   prefs.setString('newNews', newNews);
//   print('set');
// }

// Future<void> getNewNews() async {
//   final prefs = await SharedPreferences.getInstance();
//   if(prefs.containsKey('newNews'))
//   {
//     final prefsData = json.decode(prefs.getString('newNews')!) as Map;
//     _newsList.add(NewsModel(
//       id: prefsData['id'],
//       title: prefsData['title'],
//       description: prefsData['description'],
//       image: prefsData['image'],
//       url: prefsData['url'],
//       date: prefsData['date'],
//     ));
//     notifyListeners();
//     print('get');
//   }
// }

//   Future<void> addNews(NewNewsModel newNewsModel) async {
//     try {
//       final Uri url = Uri.parse('${URLs.mainUrl}/news/create');
//       var request = http.MultipartRequest('POST', url);
//       request.fields[
//                   'id'];
//       request.files.add(
//         http.MultipartFile.fromBytes(
//             'img', File(newNewsModel.img.path).readAsBytesSync(),
//             filename: newNewsModel.img.path),
//       );
//       print(newNewsModel.img.path);
//       var res = await request.send();
//       print(res.statusCode);
//     }
//     on SocketException {
//       print('1');
//     } on FormatException {
//       print('2 ');
//     } catch (e) {
//       print('error   $e');
//       rethrow;
//     }
//   }
// }

// Future<void> addNews(NewNewsModel newNewsModel) async {
//   try {
//     final Uri url = Uri.parse('${URLs.mainUrl}/news/create');
//     final response = await http.post(url, body: {
//       'id': DateTime.now().second,
//       'title': newNewsModel.title,
//       'name': 'newNewsModel.',
//       'mobile': newNewsModel.mobile,
//       'desc': newNewsModel.desc,
//       'img': http.MultipartFile.fromPath('img', newNewsModel.img.path),
//       // 'vedio': newNewsModel.vedio.path,
//       'device_key': newNewsModel.device_key
//     }, headers: {
//       'Content-Type':
//       'multipart/form-data; boundary=<calculated when request is sent>',
//       'User-Agent': 'PostmanRuntime/7.29.2',
//       'Accept': '*/*',
//       'Accept-Encoding': 'gzip, deflate, br',
//       'Connection': 'keep-alive',
//     });
// final newNews = DataModel(
//     id: DateTime
//         .now()
//         .second,
//     title: newNewsModel.title,
//     image: newNewsModel.img.toString(),
//     date: DateTime.now().toString(),
//     description: newNewsModel.desc,
//     url: '');
// print(response.body);
// if (response.statusCode == 200) {
//   print('added');
// } else {
//   print(response.statusCode);
// }
// } on SocketException {
//   print('1');
// } on FormatException {
//   print('2 ');
//   } catch (e) {
//     print('error $e');
//     rethrow;
//   }
// }

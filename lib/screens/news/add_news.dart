import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:zahran/provider/data_provider/get_data_provider.dart';
import 'package:zahran/screens/news/news_screen.dart';
import '../../app_assets/colors.dart';
import '../../provider/data_provider/add_data_provider.dart';
import '../../provider/data_provider/new_news_model.dart';

class AddNewsScreen extends StatefulWidget {
  AddNewsScreen({Key? key}) : super(key: key);
  static const String routeName = '/ Add News Screen';
  bool agreed = false;

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  var _newNews = NewDataModel(
    id: DateTime.now().second,
    title: '',
    desc: '',
    img: File(''),
    mobile: 0,
    vedio: File(''),
    device_key: ''
  );
  bool isLoading = false;
  String checkTerms = '';
  final _form = GlobalKey<FormState>();

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!widget.agreed) {
      setState(() {
        checkTerms = 'يجب الموافقه علي الشروط والاحكام';
      });
    }
    if (widget.agreed) {
      setState(() {
        checkTerms = '';
      });
    }
    if (fileImage != null) {
      setState(() {
        imageError = '';
      });
    } else {
      setState(() {
        imageError = 'حقل الصوره ضروري';
      });
    }
    if (isValid! && widget.agreed && fileImage != null) {
      setState(() {
        isLoading = true;
        _newNews =
            NewDataModel(
                id: _newNews.id,
                title: _newNews.title,
                desc: _newNews.desc,
                img: File(fileImage!.path),
                mobile: _newNews.mobile,
                vedio: File(''),
                device_key: 's'
            );
      });
      _form.currentState?.save();
      Provider.of<AddDataProvider>(context, listen: false)
          .addNews(_newNews)
          .then((value) => setState(() {
                isLoading = false;
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, NewsScreen.routeName,
                    arguments: 'الاخبار');
              }));
    } else {
      return;
    }
  }


  File? fileImage;

  String imageError = '';

  Future<void> pickImage() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      fileImage = File(imageFile!.path);
    });
  }


  Widget _bottomSheet(String title, String desc, context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            // height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
                SizedBox(
                  // height: 1800,
                  child: Text(
                    desc,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    softWrap: true,
                    textDirection: TextDirection.rtl,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      widget.agreed = true;
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => AppColors.primaryColor)),
                  child: const Text('الموافقه علي الشروط'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _termsData =
        Provider.of<GetDataProvider>(context, listen: false).termsData;

    return Scaffold(
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
                    const Text(
                      'إضافة خبر',
                      style: TextStyle(
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
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v.toString().isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newNews =
                                NewDataModel(
                                    id: _newNews.id,
                                    title: value.toString(),
                                    desc: _newNews.desc,
                                    img: File(fileImage!.path),
                                    mobile: _newNews.mobile,
                                    vedio: File(''),
                                    device_key: 's'
                                );
                                // NewsModel(
                                // id: _newNews.id,
                                // title: value.toString(),
                                // description: _newNews.description,
                                // image: _newNews.image,
                                // url: _newNews.url,
                                // date: _newNews.date);
                          },
                          decoration: InputDecoration(
                              label: const Text('عنوان الخبر'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          textInputAction: TextInputAction.next,
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v.toString().isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newNews =
                                NewDataModel(
                                    id: _newNews.id,
                                    title: _newNews.title,
                                    desc: _newNews.desc,
                                    img: File(fileImage!.path),
                                    mobile: int.parse(value.toString()),
                                    vedio: File(''),
                                    device_key: 's'
                                );
                            // NewsModel(
                                // id: _newNews.id,
                                // title: _newNews.title,
                                // description: _newNews.description,
                                // image: _newNews.image,
                                // url: _newNews.url,
                                // date: value.toString());
                          },
                          decoration: InputDecoration(
                              label: const Text('رقم الموبايل'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          textInputAction: TextInputAction.next,
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.number,
                          // controller: TextEditingController(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (v) {
                            if (v.toString().isEmpty) {
                              return 'هذا الحقل مطلوب';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newNews =
                                NewDataModel(
                                    id: _newNews.id,
                                    title: _newNews.title,
                                    desc: value.toString(),
                                    img: File(fileImage!.path),
                                    mobile: _newNews.mobile,
                                    vedio: File(''),
                                    device_key: 's'
                                );
                                // NewsModel(
                                // id: _newNews.id,
                                // title: _newNews.title,
                                // description: value.toString(),
                                // image: _newNews.image,
                                // url: _newNews.url,
                                // date: _newNews.date);
                          },
                          decoration: InputDecoration(
                              label: const Text('وصف الخبر'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     Container(
                        //         alignment: Alignment.center,
                        //         padding: const EdgeInsets.all(1),
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //               width: 1, color: AppColors.primaryColor),
                        //         ),
                        //         height: 100,
                        //         width: 100,
                        //         child: whenPreviewImage(imageController.text)
                        //         // whenPreviewImage(newImageURLController.text)
                        //         // previewURLImage.isEmpty &&
                        //         //         (!previewURLImage.startsWith('http') ||
                        //         //             !previewURLImage
                        //         //                 .startsWith('https')) &&
                        //         //         (!previewURLImage.endsWith('.png') ||
                        //         //             !previewURLImage.endsWith('.jpg'))
                        //         //     ?  Center(child: Text('EnterUrl'))
                        //         //     : Image.network(
                        //         //         previewURLImage,
                        //         //         fit: BoxFit.contain,
                        //         //       ),
                        //         ),
                        //     const SizedBox(
                        //       width: 10,
                        //     ),
                        //
                        //     Expanded(
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.end,
                        //         children: [
                        //           // TextFormField(
                        //           //   controller: imageController,
                        //           //   onFieldSubmitted: submitURl,
                        //           //   decoration: const InputDecoration(
                        //           //       label: Text('عنوان الانترنت للصوره')),
                        //           //   // textInputAction: TextInputAction.next,
                        //           //   keyboardType: TextInputType.url,
                        //           //   validator: (value) {
                        //           //     if (value.toString().isEmpty) {
                        //           //       return 'Please enter an image URL.';
                        //           //     }
                        //           //     if (!value
                        //           //             .toString()
                        //           //             .startsWith('http') &&
                        //           //         !value
                        //           //             .toString()
                        //           //             .startsWith('https')) {
                        //           //       return 'Please enter a valid URL.';
                        //           //     }
                        //           //     if (!value.toString().endsWith('.png') &&
                        //           //         !value.toString().endsWith('.jpg') &&
                        //           //         !value.toString().endsWith('.jpeg')) {
                        //           //       return 'Please enter a valid image URL.';
                        //           //     }
                        //           //     return null;
                        //           //   },
                        //           //   onSaved: (value) {
                        //           //     _newNews = NewsModel(
                        //           //         id: _newNews.id,
                        //           //         title: _newNews.title,
                        //           //         description: _newNews.description,
                        //           //         image: value.toString(),
                        //           //         url: _newNews.url,
                        //           //         date: _newNews.date);
                        //           //   },
                        //           // ),
                        //           TextButton(
                        //             onPressed: () =>
                        //                 submitURl(imageController.text),
                        //             child: const Text(
                        //               'عرض الصوره',
                        //               style: TextStyle(
                        //                 fontWeight: FontWeight.bold,
                        //                 // color: AppColors.primaryColor
                        //               ),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'صورة الخبر',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  const Text(
                                    'قم بإضافة صورة الخبر',
                                    textDirection: TextDirection.rtl,
                                  ),
                                  const Text(
                                    'يجب ان تكون الصيغه ',
                                    textDirection: TextDirection.rtl,
                                  ),
                                  const Text(
                                    ' jpg , png , jpeg',
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text(
                                    imageError,
                                    textDirection: TextDirection.rtl,
                                    style: const TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: pickImage,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: fileImage == null
                                    ? const Center(
                                        child: Icon(Icons.cloud_upload))
                                    : Image.file(fileImage!),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      enableDrag: true,
                                      context: context,
                                      // isScrollControlled: true,
                                      builder: (ctx) {
                                        return DraggableScrollableSheet(
                                          minChildSize: .8,
                                          maxChildSize: 1,
                                          initialChildSize: .8,
                                          builder: (context, scrollController) {
                                            return _bottomSheet(
                                                _termsData['title'],
                                                _termsData['desc'],
                                                context);
                                          },
                                        );
                                      });
                                },
                                child: const Text(
                                  'الشروط والاحكام',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            const Text('الموافقه علي'),
                            Checkbox(
                                value: widget.agreed,
                                onChanged: (v) {
                                  setState(() => widget.agreed = v!);
                                })
                          ],
                        ),
                        Text(
                          checkTerms,
                          style: const TextStyle(color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: _saveForm,
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => AppColors.primaryColor)),
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: (isLoading && widget.agreed)
                                ? const CircularProgressIndicator()
                                : const Text('تأكيد الخبر'),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget whenPreviewImage(String value) {
//   if (value.isNotEmpty &&
//       (value.startsWith('http') || value.startsWith('https')) &&
//       (value.endsWith('.png') || value.endsWith('.jpg'))) {
//     return Image.network(value);
//   }
//   return Text(
//     previewURL,
//     style: TextStyle(color: Theme.of(context).errorColor),
//   );
// }

// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Column(
// textDirection: TextDirection.ltr,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: const [
// Text(
// 'صورة الخبر',
// style: TextStyle(fontWeight: FontWeight.bold),
// textDirection: TextDirection.rtl,
// ),
// Text(
// 'قم بإضافة صورة الخبر',
// textDirection: TextDirection.rtl,
// ),
// Text(
// 'يجب ان تكون الصيغه ',
// textDirection: TextDirection.rtl,
// ),
// Text(
// ' jpg , png , jpeg',
// textDirection: TextDirection.rtl,
// )
// ],
// ),
// const SizedBox(
// width: 20,
// ),
// InkWell(
// onTap: () {},
// child: Container(
// width: 120,
// height: 120,
// decoration: BoxDecoration(
// color: Colors.grey.withOpacity(.5),
// borderRadius: BorderRadius.circular(20)),
// child: const Center(child: Icon(Icons.cloud_upload)),
// ),
// ),
// const SizedBox(
// width: 20,
// ),
// ],
// ),
// const SizedBox(
// height: 20,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// Column(
// textDirection: TextDirection.ltr,
// crossAxisAlignment: CrossAxisAlignment.end,
// children: const [
// Text(
// 'فيديو الخبر',
// style: TextStyle(fontWeight: FontWeight.bold),
// textDirection: TextDirection.rtl,
// ),
// Text(
// '* اختياري',
// style: TextStyle(color: Colors.red),
// textDirection: TextDirection.rtl,
// ),
// Text(
// 'قم بإضافة فيديو الخبر',
// textDirection: TextDirection.rtl,
// ),
// Text(
// 'يجب ان لا تتعدي مدة الفيديو دقيقتين ',
// softWrap: true,
// textDirection: TextDirection.rtl,
// ),
// ],
// ),
// const SizedBox(
// width: 20,
// ),
// InkWell(
// onTap: () {},
// child: Container(
// width: 120,
// height: 120,
// decoration: BoxDecoration(
// color: Colors.grey.withOpacity(.5),
// borderRadius: BorderRadius.circular(20)),
// child: const Center(child: Icon(Icons.cloud_upload)),
// ),
// ),
// const SizedBox(
// width: 20,
// ),
// ],
// ),



// final TextEditingController imageController = TextEditingController();

// Widget whenPreviewImage(String value) {
//   if (value.isNotEmpty &&
//       (value.startsWith('http') || value.startsWith('https')) &&
//       (value.endsWith('.png') || value.endsWith('.jpg'))) {
//     return Image.network(value);
//   }
//   return Text(
//     'previewURL',
//     style: TextStyle(color: Theme.of(context).errorColor),
//   );
// }

// String previewURL = 'Enter URL';
// String previewURLImage = '';
//
// void submitURl(String value) {
//   if (value.isNotEmpty &&
//       (value.startsWith('http') || value.startsWith('https')) &&
//       (value.endsWith('.png') || value.endsWith('.jpg'))) {
//     setState(() {
//       previewURLImage = value;
//     });
//   } else {
//     whenPreviewImage;
//     setState(() {
//       previewURL = 'Enter valid URL';
//     });
//   }
// }




// ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//         backgroundColor:
//             Colors.white.withOpacity(.1),
//         padding: const EdgeInsets.all(0),
//         duration: const Duration(seconds: 10),
//         // behavior: SnackBarBehavior.floating,
//         // width: 300,
//         content: _snackBar(
//             _termsData['title'],
//             _termsData['desc'])));
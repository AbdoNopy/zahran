import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:zahran/provider/data_provider/get_data_provider.dart';
import 'package:zahran/screens/news/news_screen.dart';
import 'package:zahran/screens/occasions/occasions_screen.dart';
import '../../app_assets/colors.dart';
import '../../provider/data_provider/add_data_provider.dart';
import '../../provider/data_provider/new_news_model.dart';

class AddOccScreen extends StatefulWidget {
  AddOccScreen({Key? key}) : super(key: key);
  static const String routeName = '/ Add Occ Screen';
  bool agreed = false;

  @override
  State<AddOccScreen> createState() => _AddOccScreenState();
}

class _AddOccScreenState extends State<AddOccScreen> {
  var _newOcc = NewDataModel(
      id: DateTime.now().second,
      title: '',
      desc: '',
      img: File(''),
      mobile: 0,
      vedio: File(''),
      device_key: '');
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
        _newOcc = NewDataModel(
            id: _newOcc.id,
            title: _newOcc.title,
            desc: _newOcc.desc,
            img: File(fileImage!.path),
            mobile: _newOcc.mobile,
            vedio: File(''),
            device_key: 's');
      });
      _form.currentState?.save();
      Provider.of<AddDataProvider>(context, listen: false)
          .addOcc(_newOcc)
          .then((value) => setState(() {
                isLoading = false;
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, OccasionsScreen.routeName,
                    arguments: 'المناسبات');
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
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(70),
                  topRight: Radius.circular(70),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
                SizedBox(
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
                      'إضافة مناسبة',
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
                            _newOcc = NewDataModel(
                                id: _newOcc.id,
                                title: value.toString(),
                                desc: _newOcc.desc,
                                img: File(fileImage!.path),
                                mobile: _newOcc.mobile,
                                vedio: File(''),
                                device_key: 's');
                          },
                          decoration: InputDecoration(
                              label: const Text('عنوان المناسبة'),
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
                            _newOcc = NewDataModel(
                                id: _newOcc.id,
                                title: _newOcc.title,
                                desc: _newOcc.desc,
                                img: File(fileImage!.path),
                                mobile: int.parse(value.toString()),
                                vedio: File(''),
                                device_key: 's');
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
                            _newOcc = NewDataModel(
                                id: _newOcc.id,
                                title: _newOcc.title,
                                desc: value.toString(),
                                img: File(fileImage!.path),
                                mobile: _newOcc.mobile,
                                vedio: File(''),
                                device_key: 's');
                          },
                          decoration: InputDecoration(
                              label: const Text('وصف المناسبة'),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          textDirection: TextDirection.rtl,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                textDirection: TextDirection.ltr,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'صورة المناسبة',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  const Text(
                                    'قم بإضافة صورة المناسبة',
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
                                : const Text('تأكيد المناسبة'),
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

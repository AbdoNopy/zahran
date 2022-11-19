import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zahran/provider/home_provider.dart';

import 'package:zahran/widgets/home_screen/gride_item.dart';
import '../app_assets/colors.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bannerData = Provider.of<BannerImage>(context, listen: false);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: TextButton.icon(
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
                                      return _snackBar();
                                    },
                                  );
                                });
                            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     backgroundColor: Colors.white.withOpacity(.1),
                            //     padding: const EdgeInsets.all(0),
                            //     duration: const Duration(seconds: 10),
                            //     // behavior: SnackBarBehavior.floating,
                            //     // width: 300,
                            //     content: _snackBar()));
                          },
                          icon: const Icon(Icons.headset_mic_rounded),
                          label: const Text('تواصل معنا')),
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                        height: 75,
                        child: Column(children: const [
                          Text(
                            'قبيلة زهران',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('مرحبا بك في التطبيق')
                        ])),
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/images/icon.png'),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: Provider.of<BannerImage>(context, listen: false)
                      .getImageUrl(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                          height: 100,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: bannerData.imageUrl == null
                              ? const SizedBox()
                              : Image.network(
                                  bannerData.imageUrl.toString(),
                                  fit: BoxFit.cover,
                                ));
                    }
                  },
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1 / .9),
                    itemCount: bannerData.gridData.length,
                    itemBuilder: (builder, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, bannerData.gridData[i]['routeName'],
                              arguments: bannerData.gridData[i]['title']);
                        },
                        child: GridItem(bannerData.gridData[i]['title']),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _snackBar() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        height: 225,
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
            const Text(
              'تواصل معنا',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            ),
            const Text(
              'يمكنك التواصل معنا عبر',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 300,
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  width: 50,
                  // height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.primaryColor.withOpacity(.3)),
                  child: Image.asset('assets/images/icon.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

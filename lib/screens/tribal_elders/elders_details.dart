import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zahran/app_assets/colors.dart';
import 'package:zahran/provider/data_provider/get_data_provider.dart';

class EldersDetails extends StatelessWidget {
  static const routeName = '/Occasions detail';

  const EldersDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elderId = ModalRoute.of(context)!.settings.arguments as int;
    final elderDetails =
    Provider.of<GetDataProvider>(context).findById(elderId);
    return Scaffold(
      backgroundColor: Colors.white70.withOpacity(.9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .15,
                decoration: const BoxDecoration(
                  // border: Border.all(color: AppColors.primaryColor,width: 2),
                  // image: DecorationImage(image: NetworkImage(newsDetail.image,),fit: BoxFit.fill),
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.ios_share,
                          color: Colors.white,
                          size: 30,
                        )),
                    Text(
                      elderDetails.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
              SizedBox(
                width: MediaQuery.of(context).size.width * .9,
                height: MediaQuery.of(context).size.width * .5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child:
                  Image.network(elderDetails.image, fit: BoxFit.fill),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .6,
                width: MediaQuery.of(context).size.width * .95,
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '?????????? ??????????',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                      // TextButton.icon(
                      //   style: ButtonStyle(
                      //       foregroundColor: MaterialStateColor.resolveWith(
                      //           (states) => AppColors.primaryColor)),
                      //   onPressed: () {},
                      //   label: Text(newsDetail.date),
                      //   icon: Icon(
                      //     Icons.access_time,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            elderDetails.date,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor),
                            textDirection: TextDirection.ltr,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.access_time,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      Text(
                        elderDetails.description,
                        softWrap: true,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

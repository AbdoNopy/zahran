import 'package:flutter/material.dart';
import 'package:zahran/screens/home_screen.dart';

import '../provider/data_provider/get_data_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loadingSpinner = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        loadingSpinner = false;
      });
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/splash.jpg')),
            ),
            child: loadingSpinner
                ? const CircularProgressIndicator()
                : const SizedBox()));
  }
}

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app/routes.dart';
import '../common/utils/content_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(ContentConstants.imageUrlApp),
      title: Text(
        ContentConstants.titleApp,
        style: TextStyle(
            fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      loadingText: const Text(ContentConstants.textLoading),
      durationInSeconds: 3,
      navigator: Routes.productsPage,
    );
  }
}
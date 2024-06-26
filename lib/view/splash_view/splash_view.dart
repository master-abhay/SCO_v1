import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import '../../viewModel/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late SplashServices _splashServices;
  @override
  void initState() {
    GetIt getIt = GetIt.instance;
    _splashServices = getIt.get<SplashServices>();
    _splashServices.checkUserAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
           Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset("assets/splash_bg.png",fit: BoxFit.cover,),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Image.asset("assets/company_logo.png",fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }
}

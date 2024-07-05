
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sco_v1/view/authentication/forgot_password_view.dart';

import '../../view/authentication/reset_password_view.dart';
import '../../view/authentication/sign_up_view.dart';
import '../../view/drawer/custom_drawer_view/aBriefAboutSco_view.dart';
import '../../view/drawer/custom_drawer_view/sco_programs.dart';
import '../../view/home_view.dart';
import '../../view/main_view.dart';
import '../../view/splash_view/splash_view.dart';
import '../../view/authentication/login_view.dart';

class NavigationServices {
//Creating the global key for navigation State:
  late GlobalKey<NavigatorState> _navigationStateKey;

  NavigationServices() {
    _navigationStateKey = GlobalKey<NavigatorState>();
  }

  GlobalKey<NavigatorState> get navigationStateKey => _navigationStateKey;

  //Creating Routes for the application:
  final Map<String, Widget Function(BuildContext context)> _routes = {
    "/splashView" : (context)=> const SplashView(),
    "/loginView" : (context)=> const LoginView(),
    "/signUpView" : (context)=> const SignUpView(),
    "/resetPasswordView" : (context)=> const ResetPasswordView(),
    "/forgotPasswordView" : (context)=> const ForgotPasswordView(),
    "/aBriefAboutScoView" : (context)=> const ABriefAboutScoView(),
    "/scoPrograms" : (context)=> const ScoPrograms(),





    "/mainView": (context)=> const MainView(),
  };

  //Creating getter to the routes of the application:

  Map<String, Widget Function(BuildContext context)> get routes => _routes;

  void push(MaterialPageRoute route) {
    _navigationStateKey.currentState!.push(route);
  }

  void pushNamed(String route) {
    _navigationStateKey.currentState!.pushNamed(route);
  }

  void pushReplacementNamed(String route) {
    _navigationStateKey.currentState!.pushReplacementNamed(route);
  }

  void goBack() {
    _navigationStateKey.currentState!.pop();
  }
}

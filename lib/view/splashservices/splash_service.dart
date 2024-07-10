import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) {
      if (kDebugMode) {
        print(value.token.toString());
      }
      if (value.token.toString() == 'null' || value.token.toString() == '') {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, RoutesNames.login);
        });
      } else {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamed(context, RoutesNames.home);
        });
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';


class AuthViewModel with ChangeNotifier {
  final _myrepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signuploading = false;
  bool get signuploading => _signuploading;

  signupSetLoading(bool value) {
    _signuploading = value;
    notifyListeners();
  }

  loginSetLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    loginSetLoading(true);
    _myrepo.loginApi(data).then((value) {
      loginSetLoading(false);
      // Future<UserModel> getUserData() => UserViewModel().getUser();
      final userPrefrence = Provider.of<UserViewModel>(context, listen: false);
      userPrefrence.saveUser(UserModel(token: value['token'].toString()));
      Utils.toastMessage(context, 'Login Successfully');
      Navigator.pushNamed(context, RoutesNames.home);
    }).onError((error, stackTrace) {
      loginSetLoading(false);
      (Utils.flushBarErrorMessage(error.toString(), context));
    });
  }

  Future<void> singupApi(dynamic data, BuildContext context) async {
    signupSetLoading(true);
    _myrepo.signupApi(data).then((value) {
      if (kDebugMode) {
        print(value.toString());
      }
      signupSetLoading(false);
      Utils.toastMessage(context, 'Account Registered Successfully');
      Navigator.pushNamed(context, RoutesNames.login);
    }).onError((error, stackTrace) {
      signupSetLoading(false);
      (Utils.flushBarErrorMessage(error.toString(), context));
    });
  }
}

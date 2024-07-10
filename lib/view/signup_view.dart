import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/resources/colors/app_colors.dart';
import 'package:mvvm/resources/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_names.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ValueNotifier<bool> obscurepassword = ValueNotifier<bool>(true);
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void dispose() {
    obscurepassword.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Signup'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            focusNode: emailFocus,
            controller: emailController,
            decoration: const InputDecoration(
              hintText: 'Email',
              label: Text('Email'),
              prefixIcon: Icon(Icons.alternate_email),
            ),
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(context, emailFocus, passwordFocus);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ValueListenableBuilder(
              valueListenable: obscurepassword,
              builder: ((context, value, child) {
                return TextFormField(
                  focusNode: passwordFocus,
                  obscureText: obscurepassword.value,
                  controller: passwordController,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            obscurepassword.value = !obscurepassword.value;
                          },
                          child: obscurepassword.value
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                      hintText: 'Password',
                      label: const Text('Password'),
                      prefixIcon: const Icon(Icons.password)),
                );
              })),
          SizedBox(height: height * .1),
          RoundButton(
            buttonname: 'Signup',
            onPress: () {
              if (emailController.text.isEmpty &&
                  passwordController.text.isEmpty) {
                Utils.flushBarErrorMessage('Fields are Empty', context);
              } else if (passwordController.text.isEmpty) {
                Utils.toastMessage(context, 'Password is empty');
              } else if (emailController.text.isEmpty) {
                Utils.toastMessage(context, 'email is empty');
              } else {
                Map data = {
                  'email': emailController.text.toString(),
                  'password': passwordController.text.toString(),
                };
                authViewModel.singupApi(data, context);
              }
            },
            loading: authViewModel.signuploading,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
              children: <TextSpan>[
                const TextSpan(
                  text: "already have an account? ",
                ),
                TextSpan(
                  text: 'Login',
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      color: AppColors.buttonColor,
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, RoutesNames.login);
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

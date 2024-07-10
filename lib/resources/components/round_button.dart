import 'package:flutter/material.dart';
import 'package:mvvm/resources/colors/app_colors.dart';

class RoundButton extends StatelessWidget {
  final String? buttonname;
  final bool loading;
  final VoidCallback? onPress;
  const RoundButton(
      {super.key,
      required this.buttonname,
      this.loading = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.buttonColor,
              borderRadius: BorderRadius.circular(40)),
          child: Center(
              child: loading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    )
                  : Text(
                      buttonname.toString(),
                      style: const TextStyle(color: Colors.white),
                    )),
        ),
      ),
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(2));
  }

  static toastMessage(BuildContext context, String message) {
    showToast(
      message,
      context: context,
      animation: StyledToastAnimation.slideFromBottom,
      reverseAnimation: StyledToastAnimation.slideToBottom,
      startOffset: const Offset(0.0, 3.0),
      reverseEndOffset: const Offset(0.0, 3.0),
      position: StyledToastPosition.bottom,
      duration: const Duration(seconds: 4),
      //Animation duration   animDuration * 2 <= duration
      animDuration: const Duration(seconds: 2),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        isDismissible: true,
        positionOffset: 20,
        icon: const Icon(Icons.error, size: 28, color: Colors.white),
        flushbarPosition: FlushbarPosition.TOP,
        reverseAnimationCurve: Curves.easeInOut,
        borderRadius: BorderRadius.circular(20),
        forwardAnimationCurve: Curves.decelerate,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Colors.deepOrange,
        message: message,
        duration: const Duration(seconds: 3),
      )..show(context),
    );
  }

  static snakBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocaleController extends GetxController {
  static String LANGUAGE_CODE = 'language_code';

  get initialLang => null;

  void changeLang(String codelang) async {
    Locale locale = Locale(codelang);
    Get.updateLocale(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LANGUAGE_CODE, codelang);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocaleController extends GetxController {
  static String LANGUAGE_CODE = 'language_code';

  get initialLang => null;

  @override
  void onInit() {
    super.onInit();
    _loadLanguage();
  }

  void changeLang(String codelang) async {
    Locale locale = Locale(codelang);
    Get.updateLocale(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LANGUAGE_CODE, codelang);
  }

  void _loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? codelang = prefs.getString(LANGUAGE_CODE);
    if (codelang != null) {
      Locale locale = Locale(codelang);
      Get.updateLocale(locale);
    }
  }
}

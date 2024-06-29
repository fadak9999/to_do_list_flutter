//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_flutter/language/locale_controller.dart';
import 'package:to_do_list_flutter/mode/modeProvider.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  bool star = false;

  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerllang = Get.find();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color.fromARGB(255, 189, 218, 242),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: 100,
            child: Text(
              "titleDrawer".tr,
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controllerllang.changeLang("ar");
            },
            child: Text("3".tr),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              controllerllang.changeLang("en");
            },
            child: Text("2".tr),
          ),
          Divider(
            height: 100,
          ),
          SwitchListTile(
            title: Text(
              "mod".tr,
              style: TextStyle(color: Colors.purple),
            ),
            value: star,
            onChanged: (Value) {
              setState(() {
                star = Value;
              });

              Provider.of<ModeProvider>(context, listen: false).chaneMode();
            },
          ),
        ],
      ),
    );
  }
}
//
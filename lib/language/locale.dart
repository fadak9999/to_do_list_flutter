import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "todoList": "عمل قائمة",
          "2": "انكليزي",
          "3": "عربي",
          "addtodo": "اضف للقيام به",
          "goto": "انتقل الى",
          "titleDrawer": "اختر اللغة",
          "mod": "الوضع",
          "notes": "ملحوظات",
          "addnotes": "اضافة ملحوظة",
          "title": "العنوان",
          "Description": "الوصف",
          "save": "حفظ",
          "clear": "حذف",
          "date": "التاريخ",
          "description": "وصف",
          "enterTitle": "ادخل العنوان",
          "enterdate": "ادخل التاريخ",
          "Data": "التاريخ",
          "Datenotselected": "التاريخ غير محدد",
          "EnterDescription": "ادخل الوصف",
          "YourTodoList": "قائمة المهام الخاصة بك",
          "Delete": "حذف",
          "Edit": "تعديل",
          "Deadline": "موعد التسليم"
        },
//
        "en": {
          "todoList": "Todo List",
          "2": "english",
          "3": "arabic",
          "addtodo": "Add To Do",
          "goto": "goto",
          "titleDrawer": "select a language",
          "mod": "mode",
          "title": "Title",
          "Description": "Description",
          "save": "save",
          "clear": "clear",
          "date": "date",
          "description": "Description",
          "enterTitle": "Enter Title",
          "enterdate": "Enter Date",
          "Data": "Data",
          "Datenotselected": "Date not selected!",
          "EnterDescription": "Enter Description",
          "YourTodoList": "Your Todo List",
          "Delete": "Delete",
          "Edit": "Edit",
          "Deadline": "Deadline"
        },
      };
}

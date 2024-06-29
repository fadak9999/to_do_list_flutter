import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_flutter/APIS/shared_preferences_api.dart';
import 'package:to_do_list_flutter/models/todomodel.dart';
import 'package:to_do_list_flutter/screens/setting.dart';

class display_screen extends StatefulWidget {
  const display_screen({super.key});

  @override
  State<display_screen> createState() => _display_screenState();
}

class _display_screenState extends State<display_screen> {
  //textfeld
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController data = TextEditingController();
  //
  List<todomodel> task = [];
  bool loaded = false;
  bool editpressed = false;
  int this_id = 0;

  @override
  void initState() {
    super.initState();
    poupulateList();
  }

  poupulateList() async {
    task = await shared_pref_api().getList();

    if (task != null && task.isNotEmpty) {
      setState(() {
        loaded = true;
      });
    }
  }

  getid() {
    int max = 0;
    List<int> ids = [];
    if (task != null) {
      for (var i in task) {
        ids.add(i.id.toInt());
      }
      for (int i in ids) {
        if (i > max) {
          max = i;
        }
      }
      return max + 1;
    } else {
      return 0;
    }
  }

  deleteTask(int id) {
    for (var i in task) {
      if (i.id == id) {
        task.remove(i);
        break;
      }
    }
    shared_pref_api().saveList(task);
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              child: IconButton(
                onPressed: () {
                  Get.to(setting());
                },
                icon: Icon(
                  Icons.settings,
                ),
                style: ButtonStyle(
                    iconSize: MaterialStatePropertyAll(100),
                    iconColor: MaterialStatePropertyAll(Colors.blue)),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("todoList".tr)),
      ),
      //
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(left: 25, top: 5),
                child: Text(
                  "addtodo".tr,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 50),
                          hintText: 'enterTitle'.tr,
                          labelText: 'title'.tr,
                          prefixIcon: Icon(Icons.title),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: data,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 50),
                          hintText: 'enterdate'.tr,
                          labelText: 'Data'.tr,
                          prefixIcon: Icon(Icons.calendar_month),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedData = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1));
                        if (pickedData != null) {
                          String formatedDate =
                              DateFormat('yyyy-MM-dd').format(pickedData);
                          setState(() {
                            data.text = formatedDate;
                          });
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Date not selected')));
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: description,
                      maxLines: 3,
                      decoration: InputDecoration(
                          constraints: BoxConstraints(maxHeight: 150),
                          hintText: 'EnterDescription'.tr,
                          labelText: 'description'.tr,
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue)),
                                onPressed: () {
                                  if (editpressed == false) {
                                    if (title.text.isNotEmpty &&
                                        data.text.isNotEmpty &&
                                        description.text.isNotEmpty) {
                                      task.add(todomodel(
                                          id: getid(),
                                          title: title.text,
                                          date: data.text,
                                          description: description.text));
                                      shared_pref_api().saveList(task);
                                      poupulateList();
                                    } else {
                                      print('All fields are required');
                                    }
                                  } else {
                                    if (title.text.isNotEmpty &&
                                        data.text.isNotEmpty &&
                                        description.text.isNotEmpty) {
                                      shared_pref_api().updateList(
                                          task,
                                          this_id,
                                          title.text,
                                          data.text,
                                          description.text);
                                      setState(() {
                                        this_id = 0;
                                        editpressed = false;
                                        poupulateList();
                                      });
                                    } else {
                                      print('All fields are required');
                                    }
                                  }
                                },
                                icon: Icon(
                                  Icons.save,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "save".tr,
                                  style: TextStyle(color: Colors.white),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton.icon(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.blue)),
                                onPressed: () {
                                  title.clear();
                                  data.clear();
                                  description.clear();
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "clear".tr,
                                  style: TextStyle(color: Colors.white),
                                )),
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 15,
                      endIndent: 15,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "YourTodoList".tr,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: loaded,
                            replacement:
                                Center(child: CircularProgressIndicator()),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: task.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  key: Key(task[index].id.toString()),
                                  startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      dismissible: DismissiblePane(
                                        key: Key(task[index].id.toString()),
                                        onDismissed: () {
                                          deleteTask(task[index].id);
                                        },
                                      ),
                                      children: [
                                        SlidableAction(
                                          onPressed: null,
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.blue,
                                          icon: Icons.delete,
                                          label: 'Delete'.tr,
                                        )
                                      ]),
                                  endActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            title.text = task[index].title;
                                            data.text = task[index].date;
                                            description.text =
                                                task[index].description;
                                            setState(() {
                                              editpressed = true;
                                              this_id = task[index].id;
                                            });
                                          },
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.blue,
                                          icon: Icons.edit,
                                          label: 'Edit'.tr,
                                        ),
                                      ]),
                                  child: Card(
                                    elevation: 10,
                                    color: Colors.blue,
                                    margin: EdgeInsets.all(5),
                                    child: Container(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "title".tr,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                task[index].title,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Deadline".tr,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                task[index].date,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

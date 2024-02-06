import 'package:flutter/material.dart';
import 'package:todo/database.dart';
import 'package:todo/homepage.dart';

import 'main.dart';

class Task extends StatefulWidget {

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  TextEditingController conTitle = TextEditingController();
  TextEditingController conTask = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(backgroundColor: Colors.grey,),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Db().insertData(conTitle.text,conTask.text,Splash.db).then((value) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return const HomePage();
            },));
          });
        },
        child: const Icon(Icons.save),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),

              TextField(
                controller: conTitle,
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "Note Titles",
                  border: InputBorder.none,
                ),
              ),

              const SizedBox(height: 10,),

              TextField(
                controller: conTask,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Enter Task",
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

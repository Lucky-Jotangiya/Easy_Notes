import 'package:flutter/material.dart';

import 'database.dart';

class UpdateTask extends StatefulWidget {
  String title;
  String task;
  int id;
  UpdateTask(this.title, this.task, this.id);


  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  TextEditingController conTitle = TextEditingController();
  TextEditingController conTask = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    conTitle.text = widget.title;
    conTask.text = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.white70,
          onPressed: () {

            String title = conTitle.text;
            String task = conTask.text;
            int id = widget.id;

            Db().update(title,task,id).then((value) {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            });
          },
          child: const Icon(Icons.update,color: Colors.black,),
        ),

      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.grey,
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

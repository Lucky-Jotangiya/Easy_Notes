
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/database.dart';
import 'package:todo/main.dart';
import 'package:todo/task.dart';
import 'package:todo/update%20task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,

      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white70,
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return Task();
          },));
        },
        child: const Icon(Icons.add,color: Colors.black,),
      ),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white60,
        title: const Text("Todo",style: TextStyle(color: Colors.black),),
      ),

      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 40),
            decoration: BoxDecoration(
              color: Colors.white60,
              borderRadius: BorderRadius.circular(21)
            ),
            child: TextField(
              onChanged: (value) {
                runVal(value);
              },
              decoration: const InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: Slidable(
                  endActionPane: ActionPane(motion: const DrawerMotion(), children: [
                    SlidableAction(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(21),bottomRight: Radius.circular(21)),
                      onPressed: (context) {
                        int id = taskData[index]['id'];
                        Db().remove(id, Splash.db).then((value) {
                          getData();
                        });
                      },
                      icon: Icons.delete,
                      backgroundColor: Colors.red,
                    ),
                  ]),
                  child: ListTile(
                    onTap: () {

                      String title = taskData[index]['title'];
                      String task = taskData[index]['task'];
                      int id = taskData[index]['id'];

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return UpdateTask(title,task,id);
                        },));
                    },
                    tileColor: Colors.white60,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
                    contentPadding: const EdgeInsets.all(8),
                    leading: const Icon(Icons.task,size: 30,),
                    title: Text("${taskData[index]['title']}",style: const TextStyle(fontSize: 16,),maxLines: 1,),
                    subtitle: Text("${taskData[index]['task']}",maxLines: 1,),
                  ),
                ),
              );
            },
            itemCount: taskData.length,
            ),
          ),

        ],
      ),
    );
  }

  void getData() {

    Db().viewTask(Splash.db).then((value) {
      setState(() {
        taskData = value;
        taskShow = value;
      });
    });
  }
  List<Map> taskData = [];
  List<Map> taskShow = [];
  void runVal(String keyWord) {
    List<Map> result = [];

    if (keyWord.isEmpty) {
      result = taskShow;
    } else {
      result = taskShow
          .where((element) => element['title']!
          .toLowerCase()
          .contains(keyWord.toLowerCase()))
          .toList();
    }

    setState(() {
      taskData = result;
    });
  }
}

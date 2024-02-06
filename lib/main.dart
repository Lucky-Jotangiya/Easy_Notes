import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/database.dart';
import 'package:todo/homepage.dart';

void main(){
  runApp( MaterialApp(
    routes: {
      '/home' : (context) =>  HomePage(),
    },
    home: Splash(),
  ));
}

class Splash extends StatefulWidget {

  static late SharedPreferences pref;
  static late Database db;

  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    getDatabaseBefore();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> getDatabaseBefore() async {

    Splash.pref = await SharedPreferences.getInstance();

    await Db().getDataBase().then((value) {
      setState(() {
        Splash.db = value;
      });
    });

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      },));
    });
  }
}

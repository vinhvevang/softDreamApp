import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_fresher_training/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed:() async{
          final box = Hive.box('loginBox');

          await box.put('isLogin',false);

    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()

    ));

      }, child: Text("Dang xuat"))),
    );
  }
}
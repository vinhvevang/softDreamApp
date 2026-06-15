/*
Box is the same Map, but Box in Hive will save data on memory's phone, Map is saved on Ram-
It is the re
ason why close app and open again ,some data is still saved
some steps:

`Hive.initFlutter()`- create hive for Flutter enviroment
`Hive.openBox('<String>')` - create a folder in phone
`Hive.Box('<String>')` - refer to that folder
`box.get('', <real_value in TextField> )` - read data from text field, prepare to save
`box.put('', <real_value in TextField> )` - save data from text field
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:new_fresher_training/home.dart';
import 'package:new_fresher_training/login.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();  // create widget
    await Hive.initFlutter(); // create hive
    await Hive.openBox('loginBox');// create a loginBox  in phone
  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Box box = Hive.box('loginBox');// refer to this folder in phone(Compulsory line)
    bool isLogin =  box.get('isLogin',defaultValue: false);
    return MaterialApp(home:isLogin ? const Home() :const Login(),debugShowCheckedModeBanner: false,);
  } 
}
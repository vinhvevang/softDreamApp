import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_fresher_training/Listproducts_page.dart';
import 'package:new_fresher_training/account.dart';
import 'package:new_fresher_training/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  void selectedButton(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  List<Widget> buttonList = [ListProductsPage(),Account()];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: buttonList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectedButton,
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xFFF24E1E),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: "account")
        ]),
    );
  }
}
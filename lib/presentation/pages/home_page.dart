import 'package:flutter/material.dart';
import 'account_page.dart';
import 'list_products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    ListProductsPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => selectedIndex = index),
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFFF24E1E),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "account"),
        ],
      ),
    );
  }
}
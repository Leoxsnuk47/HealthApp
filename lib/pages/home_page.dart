import 'package:flutter/material.dart';
import 'package:hobi/pages/reminder_pag.dart';
import 'package:hobi/pages/settings_page.dart';

import '../components/g_nav.dart';
import 'chat_page.dart';
import 'initial_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

   int _selectedIndex = 0;

class _HomePageState extends State<HomePage> {
  void NavigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages =[
    const InitialHomePage(),
    const ChatPage(),
    const ReminderPage(),
     const SettingsPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: GNavBar(
        onTabChange: (index) => NavigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

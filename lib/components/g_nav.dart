import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GNavBar extends StatefulWidget {
  void Function(int)? onTabChange;

  GNavBar({
    super.key,
    required this.onTabChange,
  });

  @override
  State<GNavBar> createState() => _GNavBarState();
}

class _GNavBarState extends State<GNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25, top: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          color: const Color(0xffDEE2ED),
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 2),
          child: GNav(
            color: Colors.grey.shade500,
            activeColor: Colors.grey.shade800,
            tabActiveBorder: Border.all(
              color: Colors.blue,
            ),
            tabBorderRadius: 22,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly distribute buttons
            tabBackgroundColor: const Color(0xff1067F5).withOpacity(0.3),
            onTabChange: (value) => widget.onTabChange!(value),
            tabs: const [
              GButton(
                padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 24.0),
                icon: Icons.home_outlined,
                text: 'Home',
              ),
              GButton(
                padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 24.0),
                icon: Icons.message_outlined,
                text: 'Message',
              ),
              GButton(
                padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 24.0),
                icon: Icons.receipt_long_outlined,
                text: 'Reminder',
              ),
              GButton(
                padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 24.0),
                icon: Icons.settings_outlined,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

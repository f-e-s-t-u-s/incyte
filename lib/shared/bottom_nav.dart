import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incyte/profile/profile.dart';
import 'package:incyte/report/report_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.phone,
              size: 20,
            ),
            label: 'Hotlines'),
        BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bolt,
              size: 20,
            ),
            label: 'Report'),
        BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.circleUser,
              size: 20,
            ),
            label: 'Profile'),
      ],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            //do nothing
            break;
          case 1:
            // Navigator.pushNamed(context, '/report');
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ReportScreen())
            );
            break;
          case 2:
            // Navigator.pushNamed(context, '/profile');
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const ProfileScreen())
            );

        }
      },
    );
  }
}

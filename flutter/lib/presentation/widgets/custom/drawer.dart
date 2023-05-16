import 'package:flutter/material.dart';

import '../helper/helper_widget.dart';
import 'clip_path_bg.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.10,
      child: Column(
        children: [
          Stack(
            children: [
              const ClipPathBackground(height: 400),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowBuilder(
                  'assets/image/ehotline.png',
                  'Hotline Number',
                  () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

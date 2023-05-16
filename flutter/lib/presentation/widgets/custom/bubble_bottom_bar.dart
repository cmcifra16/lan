import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_demo/general/text.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../../../screens/theme/color.dart';

class CustomBubbleBar extends StatelessWidget {
  final int currentIndex;
  final Function(int?)? onTap;
  const CustomBubbleBar({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BubbleBottomBar(
      opacity: .2,
      currentIndex: currentIndex,
      onTap: onTap,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      elevation: 8,
      hasNotch: false, //new
      items: [
        BubbleBottomBarItem(
            backgroundColor: Colors.purpleAccent.shade200.withOpacity(0.4),
            icon: const Iconify(Mdi.map_marker, color: primary),
            activeIcon: const Iconify(Mdi.map_marker, color: black),
            title: const CustomText("Map", color: black)),
        BubbleBottomBarItem(
            backgroundColor: Colors.purpleAccent.shade200.withOpacity(0.4),
            icon: const Iconify(Ic.baseline_home, color: primary),
            activeIcon: const Iconify(Ic.baseline_home, color: black),
            title: const CustomText("Home", color: black)),
        BubbleBottomBarItem(
            backgroundColor: Colors.purpleAccent.shade200.withOpacity(0.4),
            icon: const Iconify(Ion.ios_megaphone, color: primary),
            activeIcon: const Iconify(Ion.ios_megaphone, color: black),
            title: const CustomText("Announcement", color: black)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth_demo/general/text.dart';
import '../custom/clip_path_bg.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomHomeContainer(height: double.infinity),
        Center(
          child: Container(
            height: 500,
            margin: const EdgeInsets.all(15),
            width:
                MediaQuery.of(context).size.width > 700 ? 600 : double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    'Announcement!'.toUpperCase(),
                    weight: FontWeight.w700,
                    size: 14,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

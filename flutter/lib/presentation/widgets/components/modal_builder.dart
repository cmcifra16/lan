import 'package:flutter/material.dart';
import 'package:firebase_auth_demo/general/text.dart';

import '../../../screens/theme/color.dart';
import '../helper/helper_widget.dart';

class ModalBuilder extends StatelessWidget {
  final String calamity;
  final String description;
  final String alertDesc;
  final String guideline1;
  final String image1;
  final String guideline2;
  final String image2;
  final String guideline3;
  final String image3;
  const ModalBuilder({
    super.key,
    required this.calamity,
    required this.description,
    required this.alertDesc,
    required this.guideline1,
    required this.image1,
    required this.guideline2,
    required this.image2,
    required this.guideline3,
    required this.image3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 680,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primary,
            primary,
            tertiary,
          ],
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomText(
                  calamity,
                  size: 20,
                  weight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: CustomText(
                  color: Colors.white,
                  description,
                ),
              ),
              verticalSpace(10),
              Padding(
                padding: const EdgeInsets.all(12),
                child: CustomText(
                  color: Colors.white,
                  alertDesc,
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomText(
                    guideline1,
                    color: Colors.white,
                  ),
                ),
                Expanded(child: Image.asset(image1))
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Image.asset(image2)),
                Expanded(
                  child: CustomText(
                    guideline2,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomText(
                    guideline3,
                    color: Colors.white,
                  ),
                ),
                Expanded(child: Image.asset(image3))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

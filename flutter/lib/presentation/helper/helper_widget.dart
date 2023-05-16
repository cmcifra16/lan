import 'package:flutter/material.dart';
import 'package:firebase_auth_demo/general/text.dart';

Widget columnBuilder(String text, String imagePath, VoidCallback? function) {
  return GestureDetector(
    onTap: function,
    child: Column(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(imagePath),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomText(
            text,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}

Widget rowBuilder(String imagePath, String label, Function()? function) {
  return GestureDetector(
    onTap: function,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            imagePath,
            height: 30,
          ),
        ),
        CustomText(
          label,
          color: Colors.grey.shade600,
          size: 16,
          weight: FontWeight.w500,
        )
      ],
    ),
  );
}

Widget verticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget horizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}

Widget containerBuilder(String imagePath, String branch, String contact) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0xfffbffff),
          offset: Offset(-5.0, -5.0),
          blurRadius: 10,
          spreadRadius: 0.0,
        ),
        BoxShadow(
          color: Color(0xffdde1e4),
          offset: Offset(5.0, 5.0),
          blurRadius: 10,
          spreadRadius: 0.0,
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.network(
          imagePath,
          height: 80,
          width: 80,
        ),
        CustomText(
          branch,
          color: Colors.red,
          weight: FontWeight.bold,
        ),
        CustomText(
          contact,
          color: Colors.black,
          weight: FontWeight.bold,
        ),
      ],
    ),
  );
}

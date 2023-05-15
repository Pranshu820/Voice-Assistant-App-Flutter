import 'package:flutter/material.dart';

import './pallete.dart';

class FeatureBox extends StatelessWidget {
  final String headerText;
  final String bodyText;
  final Color color;

  const FeatureBox(
      {super.key,
      required this.headerText,
      required this.bodyText,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 18,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        color: color,
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerText,
            style: const TextStyle(
              fontFamily: 'Cera Pro',
              fontSize: 25,
              color: Pallete.mainFontColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            bodyText,
            style: const TextStyle(
              fontFamily: 'Falling Sky',
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';

class CardWeather extends StatelessWidget {
  final String text;
  final String largeText;
  final String icon;
  const CardWeather({super.key, required this.text, required this.largeText, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: kDark,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: kSmallCardSubTextBoldStyle,
                ),
                const SizedBox(width: 10),
                Image(
                  image: AssetImage('images/$icon.png'),
                  height: 30,
                  width: 30,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              largeText,
              style: kLargeCardSubTextBoldStyle,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
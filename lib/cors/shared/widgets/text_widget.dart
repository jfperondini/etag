import 'package:etag/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double? fontSize;

  const TextWidget({
    super.key,
    required this.title,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Styles.ice,
        fontSize: fontSize,
      ),
    );
  }
}

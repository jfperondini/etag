import 'package:etag/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final Function()? onPressed;
  const IconButtonWidget({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: Styles.ice,
      ),
      onPressed: onPressed,
    );
  }
}

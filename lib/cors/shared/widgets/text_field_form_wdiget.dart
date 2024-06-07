import 'package:etag/cors/shared/styles/styles.dart';
import 'package:flutter/material.dart';

class TextFieldFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final Function()? onTap;
  final Function()? onPressed;

  const TextFieldFormWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.onTap,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Styles.ice,
      decoration: InputDecoration(
        filled: true,
        fillColor: Styles.grey,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.grey),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.grey),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Styles.grey),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Styles.ice,
        ),
        contentPadding: const EdgeInsets.only(left: 16, right: 16),
        prefixIcon: Icon(
          icon,
          color: Styles.ice,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.clear,
            color: Styles.ice,
          ),
          onPressed: onPressed,
        ),
        counterStyle: TextStyle(color: Styles.ice),
      ),
      style: TextStyle(color: Styles.ice),
      onTap: onTap,
    );
  }
}

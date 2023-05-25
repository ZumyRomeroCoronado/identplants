import 'package:flutter/material.dart';
import 'package:ident_plant/color/app_theme.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.onpres});

  final String text;
  final VoidCallback onpres;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      onPressed: onpres,
      elevation: 20,
      color: AppTheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}

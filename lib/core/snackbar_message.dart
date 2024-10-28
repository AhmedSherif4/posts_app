import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String message, required Color color}){
  final SnackBar snackBar = SnackBar(
    content: Text(message, style: const TextStyle(color: Colors.white),),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
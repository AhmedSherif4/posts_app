import 'package:flutter/material.dart';

Widget showTextFormField(
    {required TextEditingController controller,
    required String name,
    required bool isTitle}) {
  return TextFormField(
    controller: controller,
    maxLines: isTitle ? 1 : 7,
    minLines: isTitle ? 1 : 7,
    textAlign: isTitle ? TextAlign.center : TextAlign.justify,
    validator: (value) => value!.isEmpty ? 'This $name can\'t be empty' : null,
    decoration: InputDecoration(hintText: name),
  );
}

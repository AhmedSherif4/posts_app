import 'package:flutter/material.dart';

import 'dialog.dart';

Widget showAddUpdateBtn(
    {required bool isUpdatePost, required Function() onPressed}) {
  return ElevatedButton.icon(
    icon: isUpdatePost
        ? const Icon(Icons.edit_rounded)
        : const Icon(Icons.add_rounded),
    onPressed: onPressed,
    label: isUpdatePost
        ? const Text('dude, update it...')
        : const Text('Add your pretty post'),
  );
}

Widget showDeleteBtn({required BuildContext context, required int postId}) {
  return ElevatedButton.icon(
    icon: const Icon(Icons.delete_forever_rounded),
    onPressed: () => deleteDialog(context: context, postId: postId),
    label: const Text('Delete this shit!'),
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white))),
  );
}



import 'package:flutter/material.dart';

import '../../../../../core/refresh_function.dart';

class MessageDisplayWidget extends StatelessWidget {
  final String message;

  const MessageDisplayWidget({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    // ريفريش انديكيتور مابتشتغلش غير مع حاجة سكرولابل، ولكن ليست فيو هاتخلي السنتر مالهوش لازمة
    // فعشان كدا خليت فيه ستاك جواه ليست فيو وجنبه الحاجة اللي انا عاوزها
    return RefreshIndicator(
      child: Stack(
        children: [
          ListView(),
          Center(
            child: Text(
              message,
              style: const TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
      onRefresh: () => onRefresh(context),

    );
  }
}

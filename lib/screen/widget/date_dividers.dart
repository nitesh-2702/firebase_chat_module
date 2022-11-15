import 'package:firebase_chat_module/utils/app_color.dart';
import 'package:flutter/material.dart';


class DateDivider extends StatelessWidget {
  const DateDivider({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            date,
            style: Theme.of(context).textTheme.caption?.copyWith(
                fontWeight: FontWeight.w500, color: AppColors.black05),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 1,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

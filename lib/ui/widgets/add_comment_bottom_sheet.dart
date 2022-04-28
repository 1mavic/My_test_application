import "package:flutter/material.dart";
import 'package:flutter_test_application/styles/app_colors.dart';

class AddCommentWidget extends StatelessWidget {
  const AddCommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: "Имя",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: "Email",
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: 5,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            hintText: "Комментарий",
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: AppColors.green,
            child: const Center(
              child: Text(
                "Отправить",
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

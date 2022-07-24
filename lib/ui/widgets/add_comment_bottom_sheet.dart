import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:flutter_test_application/domain/bloc/comment_bloc/comment_bloc.dart";
import "package:flutter_test_application/styles/app_colors.dart";
import "package:flutter_test_application/utils/form_validator.dart";

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddCommentWidget extends HookWidget {
  const AddCommentWidget({
    Key? key,
    required this.commentBloc,
  }) : super(key: key);
  final CommentBloc commentBloc;
  bool _sendForm(String name, String email, String comment) {
    if (_formKey.currentState?.validate() ?? false) {
      commentBloc.add(
        SendCommentEvent(
          name,
          email,
          comment,
        ),
      );
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameContorller = useTextEditingController();
    final TextEditingController _emailContorller = useTextEditingController();
    final TextEditingController _commentContorller = useTextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameContorller,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              hintText: "Имя",
            ),
            validator: simpleTextValidator,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailContorller,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
            validator: emailTextValidator,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _commentContorller,
            maxLines: 5,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              if (_sendForm(
                _nameContorller.text,
                _emailContorller.text,
                _commentContorller.text,
              )) {
                Navigator.of(context).pop();
              }
            },
            decoration: const InputDecoration(
              hintText: "Комментарий",
            ),
            validator: simpleTextValidator,
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              if (_sendForm(
                _nameContorller.text,
                _emailContorller.text,
                _commentContorller.text,
              )) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.blue,
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: const Center(
                child: Text(
                  "Отправить",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

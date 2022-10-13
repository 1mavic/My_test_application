import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:my_app/domain/bloc/comment_bloc/comment_bloc.dart";
import "package:my_app/localization/localization.dart";
import "package:my_app/ui/widgets/button.dart";
import "package:my_app/utils/form_validator.dart";

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class AddCommentWidget extends HookWidget {
  const AddCommentWidget({
    super.key,
    required this.commentBloc,
  });
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
    final TextEditingController nameContorller = useTextEditingController();
    final TextEditingController emailContorller = useTextEditingController();
    final TextEditingController commentContorller = useTextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: nameContorller,
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
            controller: emailContorller,
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
            controller: commentContorller,
            maxLines: 5,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {
              if (_sendForm(
                nameContorller.text,
                emailContorller.text,
                commentContorller.text,
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
          MyButton(
            onPressed: () {
              if (_sendForm(
                nameContorller.text,
                emailContorller.text,
                commentContorller.text,
              )) {
                Navigator.of(context).pop();
              }
            },
            text: context.localize(AppLocKeys.addComment),
          )
        ],
      ),
    );
  }
}

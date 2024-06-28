import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;
  const MessageFieldBox({super.key, required this.onValue });

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final color = Theme.of(context).colorScheme;

    final focusNode = FocusNode();

    final outLineInputBorder = UnderlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(color: color.primary));

    final inputDec = InputDecoration(
      hintText: 'Enter your messsage with a "?"',
      enabledBorder: outLineInputBorder,
      focusedBorder: outLineInputBorder,
      filled: true,
      suffixIcon: IconButton(
        icon: const Icon(Icons.send_outlined),
        onPressed: () {
          final textVal = textController.value.text;
          textController.clear();
          onValue(textVal);
        },
      ),
    );

    return TextFormField(
      onTapOutside: (event) {
        focusNode.unfocus();
      },
        focusNode: focusNode,
        controller: textController,
        decoration: inputDec,
        onFieldSubmitted: (value) {
          textController.clear();
          focusNode.requestFocus();
          onValue(value);
        },
);
  }
}

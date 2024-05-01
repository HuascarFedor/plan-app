import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final String title;
  final String decoration;
  final Function(String) onAdd;
  AddDialog(
      {Key? key,
      required this.title,
      required this.decoration,
      required this.onAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(hintText: decoration),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
        TextButton(
          onPressed: () {
            if (_textEditingController.text.isNotEmpty) {
              onAdd(_textEditingController.text);
              _textEditingController.clear();
              Navigator.of(context).pop();
            }
          },
          child: const Text("Añadir"),
        ),
      ],
    );
  }
}

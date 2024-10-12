import 'package:flutter/material.dart';

customalert(
    {required BuildContext context,
    required TextEditingController controller,
    String value = "",
    required void Function()? onPressed}) {
  controller.text = value;
  return AlertDialog(
    title: Text("Your item"),
    actions: [
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
            label: Text("content"),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
      SizedBox(height: 40),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                controller.text = "";
              },
              child: Text(
                "cancel",
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: onPressed,
              child: Text(
                "save",
                style: TextStyle(color: Colors.blue),
              ))
        ],
      )
    ],
  );
}

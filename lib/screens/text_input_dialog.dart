// Copyright (c) 2024 Rainbow Shifter (https://rainbowshifter.com). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// Shows a dialog box that allows the user to enter a list of color codes or names.
///
/// The dialog box includes a multiline TextField where the user can enter their input.
/// The input is expected to be a list of color codes or names, separated by commas.
/// The function trims whitespace and converts the input to lower case before returning it.
///
/// The function returns a Future that completes with the list of color codes or names
/// entered by the user when they click the submit button. If the user clicks the cancel
/// button, the Future completes with an empty list.
///
/// The dialog box is sized relative to the screen dimensions.
///
/// [context] is the BuildContext to use for showing the dialog box.
Future<List<String>> showTextInputDialog(BuildContext context) async {
  String inputText = '';

  bool result = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Enter Color Codes'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          child: TextField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              inputText = value;
            },
            decoration: const InputDecoration(
              hintText: '#FFFFFF\n#000000\n#FF0000\n#00FF00\n#0000FF',
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Submit'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (result == true) {
    return inputText.split('\n').where((line) => line.isNotEmpty).toList();
  }

  return [];
}

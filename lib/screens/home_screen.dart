// Copyright (c) 2024 Rainbow Shifter (https://rainbowshifter.com). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

import 'text_input_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Color> _colors = <Color>[];

  void _inputText() async {
    List<String> inputText = await showTextInputDialog(context);
    if (inputText.isNotEmpty) {
      setState(() {
        _colors = inputText.map((color) => ColorUtils.parseHex(color)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RS Colors Visualizer (${_colors.length})'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _inputText,
            ),
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          // try to fit as many columns as possible, but still have a square aspect ratio and wide enough to display a color swatch
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 256,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),

          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 3,
          // ),
          itemCount: _colors.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: _colors[index],
              child: Center(
                child: Text(
                  _colors[index].toHex(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: _colors[index].contrastColor,
                      ),
                ),
              ),
            );
          },
        ));
  }
}

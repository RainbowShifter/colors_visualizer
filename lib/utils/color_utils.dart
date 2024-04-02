// Copyright (c) 2024 Rainbow Shifter (https://rainbowshifter.com). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

/// A collection of utility methods for working with colors.
///
/// Currently provides methods for converting colors to and from RGB hexadecimal strings.
extension ColorUtils on Color {
  /// Returns the RGB hexadecimal string representation of this color.
  ///
  /// Any alpha channel information is ignored. For example, the color value `0xFFAABBCC` will be
  /// returned as `#AABBCC`.
  String toHex() {
    return '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
  }

  /// Creates a new [Color] from the given RGB hexadecimal string.
  ///
  /// The [hex] string must be a standard 6-character RGB hexadecimal string, with or without a
  /// leading dash. The alpha channel is set to 255 (fully opaque). If the given string is not a
  /// valid hexadecimal color, a [FormatException] is thrown.
  static Color parseHex(String hex) {
    // Remove the leading # if present
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }

    // Handle 3-character hex codes by expanding them to 6 characters
    if (hex.length == 3) {
      hex = hex.split('').map((char) => char * 2).join();
    }

    if (hex.length == 6) {
      final int code = int.parse(hex, radix: 16);
      return Color(code).withOpacity(1.0);
    }

    throw FormatException('Invalid hex color: $hex');
  }

  /// Returns the black or white contrast color of this color.
  Color get contrastColor {
    return ThemeData.estimateBrightnessForColor(this) == Brightness.light
        ? Colors.black
        : Colors.white;
  }
}

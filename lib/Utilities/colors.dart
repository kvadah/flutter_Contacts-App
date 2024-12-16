import 'dart:math';

import 'package:flutter/material.dart';

final List<Color> predefinedColors = [
  Colors.green,
  Colors.orange,
  Colors.blue,
  Colors.purple,
  Colors.red,
  Colors.teal,
];

// Function to pick a random color from the list
Color getRandomColor() {
  final random = Random();
  return predefinedColors[random.nextInt(predefinedColors.length)];
}
import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.black,
  minimumSize: Size(double.infinity, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
final ButtonStyle raisedButtonStyleRound = ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: Colors.black,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
  // foregroundColor: Colors.white
);

final ButtonStyle raisedButtonStyleForm = ElevatedButton.styleFrom(
  backgroundColor: Colors.black,
  elevation: 0,
  minimumSize: Size(double.infinity, 36),
  padding: EdgeInsets.symmetric(vertical: 14),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

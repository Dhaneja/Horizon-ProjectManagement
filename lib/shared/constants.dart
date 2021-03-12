import 'package:flutter/material.dart';

const textInputStyle = InputDecoration(
  border: OutlineInputBorder(),
  contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlue, width: 2.0)
  ),
);
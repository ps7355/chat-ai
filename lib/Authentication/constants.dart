import 'package:flutter/material.dart';

AppBar appBar(String title) => AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
    );

const optionText = Text(
  'Or',
  style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  ),
  textAlign: TextAlign.center,
);

const spacer = SizedBox(
  height: 12,
);

const apiSceretKey = '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';
const stripeKey =
    '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';

import 'dart:ui';

import 'package:flutter/material.dart';

headingTxt({Color? color}){

  return TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: color ?? Colors.black,
  );
}


bodyTxt({Color? color}){

  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: color ?? Colors.black,
  );
}


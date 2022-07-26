import 'package:chat/constants/app_colors.dart';
import 'package:chat/constants/app_size.dart';
import 'package:flutter/material.dart';

RawMaterialButton customButton(String text, GestureTapCallback onPressed) {
  return RawMaterialButton(
    onPressed: onPressed,
    fillColor: greenColor,
    splashColor: Colors.greenAccent,
    // ignore: sort_child_properties_last
    child: Padding(
      padding: const EdgeInsets.all(Sizes.s10),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: Sizes.s16, letterSpacing: 1),
      ),
    ),
    shape: const StadiumBorder(),
  );
}

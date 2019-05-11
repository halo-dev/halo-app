import 'package:flutter/material.dart';

bool firstInit = false;

abstract class BaseState<T extends StatefulWidget> extends State<T> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!firstInit) {
      firstInit = true;
      onFirstInit();
    }
  }

  void onFirstInit();
}
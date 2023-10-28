import 'package:flutter/material.dart';

class RemoveGlow extends ScrollBehavior
{
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child,details) {
    return child;
  }
}



import 'package:button_to_action/viewmodels/HomeScreenViewmodel.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class ActionButtonWidget extends StatefulWidget {
  final _state = _ActionButtonWidgetState();

  void rotate() {
    _state.rotate();
  }

  @override
  _ActionButtonWidgetState createState() => _state;
}

class _ActionButtonWidgetState extends State<ActionButtonWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  void rotate() {
    _animationController.forward();
  }

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animationController.value * 2 * pi,
            child: child,
          );
        },
        child: FlatButton(
          child: Text('Action Button'),
          onPressed: () {
            Provider.of<HomeScreenViewModel>(context, listen: false)
                .handlePress();
          },
        ),
      ),
    );
  }
}

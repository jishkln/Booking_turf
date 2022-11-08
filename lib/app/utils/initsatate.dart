import 'package:flutter/material.dart';

/// Wrapper for stateful functionality to provide onInit calls in stateles widget
class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({super.key, required this.onInit, required this.child});
  @override
  StatefulWrapperState createState() => StatefulWrapperState();
}
class StatefulWrapperState extends State<StatefulWrapper> {
@override
  void initState() {
    widget.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
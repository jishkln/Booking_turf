import 'package:flutter/material.dart';

class CoustomScrollProvider extends ChangeNotifier {
  final ScrollController _controller = ScrollController();
  final bool _notify = false;

  get notidy => _notify;

  double _offset = 0.0;
  get offset => _offset;
  get controller => _controller;

  void initState() {
    _controller.addListener(() {
      _offset = _controller.offset;
      notifyListeners();
    });
  }
}

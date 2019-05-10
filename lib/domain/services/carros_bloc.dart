import 'dart:async';

import 'carro_service.dart';

class CarrosBlock {
  final _controller = StreamController();

  fetch(String type) {
    //Web Service.
    return CarroService.getCarros(type).then((cars) {
      _controller.sink.add(cars);
    }).catchError((error) {
      _controller.addError(error);
    });
  }

  get getStream => _controller.stream;

  close() {
    _controller.close();
  }
}

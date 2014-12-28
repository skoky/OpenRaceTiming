
import 'dart:html';
import 'dart:js';
import 'package:polymer/polymer.dart';
export 'package:polymer/init.dart';

@CustomTag('create-event')
class CreateEvent extends PolymerElement {
  @observable int page = 0;

  CreateEvent.created() : super.created();

  add(e) {
    print("Add called");


  }
  complete() {
    // complete handling goes here...
  }
}
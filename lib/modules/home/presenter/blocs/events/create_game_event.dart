import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home_event.dart';

class CreateGameEvent extends HomeEvent {
  CreateGameEvent({
    required this.input,
    required this.context,
  });
  final String input;
  final BuildContext context;
}

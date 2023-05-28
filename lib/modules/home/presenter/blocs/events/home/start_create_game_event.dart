import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/presenter/blocs/events/home/home_event.dart';

class StartCreateGameEvent extends HomeEvent {
  StartCreateGameEvent({
    required this.input,
    required this.context,
  });
  final String input;
  final BuildContext context;
}

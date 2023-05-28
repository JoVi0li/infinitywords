import 'package:flutter/material.dart';
import 'package:infinitywords/modules/home/domain/enums/dificult_enum.dart';

class DificultGameButtonComponent extends StatefulWidget {
  const DificultGameButtonComponent({
    super.key,
    required this.dificult,
    required this.onPressed,
    required this.dificultSelected,
  });
  final GameDificultEnum dificult;
  final GameDificultEnum dificultSelected;
  final void Function(GameDificultEnum dificult) onPressed;

  @override
  State<DificultGameButtonComponent> createState() =>
      _DificultGameButtonComponentState();
}

class _DificultGameButtonComponentState
    extends State<DificultGameButtonComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return OutlinedButton(
      onPressed: () => widget.onPressed(widget.dificult),
      style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
            fixedSize: MaterialStatePropertyAll(
              Size(screenSize.width * 0.25, 60),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.all(0),
            ),
            backgroundColor: widget.dificultSelected == widget.dificult
                ? const MaterialStatePropertyAll(Color(0xFF313040))
                : null,
          ),
      child: Text(
        widget.dificult.translatedValue,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

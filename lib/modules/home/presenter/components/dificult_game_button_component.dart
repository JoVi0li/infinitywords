import 'package:flutter/material.dart';

class DificultGameButtonComponent extends StatefulWidget {
  const DificultGameButtonComponent({
    super.key,
    required this.dificult,
    required this.onPressed,
    required this.selectedKey,
  });
  final String dificult;
  final void Function(GlobalKey key) onPressed;
  final GlobalKey selectedKey;

  @override
  State<DificultGameButtonComponent> createState() =>
      _DificultGameButtonComponentState();
}

class _DificultGameButtonComponentState
    extends State<DificultGameButtonComponent> {
  late final GlobalKey key;

  @override
  void initState() {
    super.initState();
    key = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return OutlinedButton(
      onPressed: () => widget.onPressed(key),
      style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
            fixedSize: MaterialStatePropertyAll(
              Size(screenSize.width * 0.25, 60),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.all(0),
            ),
            backgroundColor: widget.selectedKey == key
                ? const MaterialStatePropertyAll(Color(0xFF313040))
                : null,
          ),
      child: Text(
        widget.dificult,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

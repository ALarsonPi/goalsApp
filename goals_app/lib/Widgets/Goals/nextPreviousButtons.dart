import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NextPreviousButtons extends StatefulWidget {
  Function next;
  Function previous;
  int currentSlideIndex;
  NextPreviousButtons(this.currentSlideIndex, this.next, this.previous);

  @override
  State<StatefulWidget> createState() {
    return _NextPreviousButtons();
  }
}

class _NextPreviousButtons extends State<NextPreviousButtons> {
  previous() {
    if (widget.currentSlideIndex == 1) {
      return null;
    } else {
      setState(() {
        widget.currentSlideIndex--;
      });
      widget.previous();
      return {};
    }
  }

  next() {
    if (widget.currentSlideIndex == 4) {
      return null;
    } else {
      setState(() {
        widget.currentSlideIndex++;
      });
      widget.next();
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: (widget.currentSlideIndex == 1)
                ? null
                : () => widget.previous(),
            child: const Text("←  PREVIOUS"),
          ),
          ElevatedButton(
            onPressed: (widget.currentSlideIndex == 3) ? null : () => next(),
            child: const Text("  NEXT     →"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Settings/global.dart';

class NextPreviousButtons extends StatefulWidget {
  final int firstIndex;
  final int lastIndex;
  Function next;
  Function previous;
  int currentSlideIndex;
  NextPreviousButtons(this.currentSlideIndex, this.next, this.previous,
      this.firstIndex, this.lastIndex);

  @override
  State<StatefulWidget> createState() {
    return _NextPreviousButtons();
  }
}

class _NextPreviousButtons extends State<NextPreviousButtons> {
  previous() {
    if (widget.currentSlideIndex == widget.firstIndex) {
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
    if (widget.currentSlideIndex == widget.lastIndex) {
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
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: Global.buttonHeight,
            child: ElevatedButton(
              onPressed: (widget.currentSlideIndex == (widget.firstIndex + 1))
                  ? null
                  : () => widget.previous(),
              child: const Text("←  PREVIOUS"),
            ),
          ),
          SizedBox(
            height: Global.buttonHeight,
            child: ElevatedButton(
              onPressed: (widget.currentSlideIndex == (widget.lastIndex - 1))
                  ? null
                  : () => next(),
              child: const Text("  NEXT     →"),
            ),
          ),
        ],
      ),
    );
  }
}

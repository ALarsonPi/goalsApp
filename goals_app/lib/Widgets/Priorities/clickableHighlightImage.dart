import 'package:flutter/material.dart';

class ClickableHighlightImage extends StatefulWidget {
  ClickableHighlightImage(this.imageUrl, this.parentFunction, this.checkParent,
      this.clearParents, this.index, this.shouldBeHighlighted,
      {Key? key})
      : super(key: key);
  String imageUrl;
  Function parentFunction;
  Function checkParent;
  Function clearParents;
  bool isHighlighted = false;
  bool shouldBeHighlighted = true;
  int index;

  @override
  State<StatefulWidget> createState() {
    return _ClickableHighlightImage();
  }
}

class _ClickableHighlightImage extends State<ClickableHighlightImage> {
  List<Color> possibleColors = List.empty(growable: true);
  GestureDetector currentGestureDetector = GestureDetector();

  @override
  void initState() {
    possibleColors.add(Colors.transparent);
    possibleColors.add(Colors.red);

    if (widget.shouldBeHighlighted) {
      widget.isHighlighted = true;
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  void changeHighlightColor() {
    if (!mounted) {
      return;
    }
    setState(() {
      if (widget.checkParent()[0] && widget.checkParent()[1] == widget.index) {
        widget.isHighlighted = !widget.isHighlighted;
        String stringToReturn = "None";
        widget.parentFunction(stringToReturn, simulateTap);
      } else if (widget.checkParent()[0] &&
          widget.checkParent()[1] != widget.index) {
        widget.clearParents(widget.index, simulateTap);
      } else if (!widget.checkParent()[0]) {
        widget.isHighlighted = !widget.isHighlighted;
        String stringToReturn;
        if (widget.isHighlighted) {
          stringToReturn = widget.imageUrl;
        } else {
          stringToReturn = "None";
        }
        widget.parentFunction(
          stringToReturn,
          simulateTap,
        );
      }
    });
  }

  simulateTap() {
    currentGestureDetector.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    currentGestureDetector = GestureDetector(
      onTap: () => {changeHighlightColor()},
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              width: 3.0,
              color: (widget.isHighlighted)
                  ? possibleColors[1]
                  : possibleColors[0]),
          image: DecorationImage(
            image: NetworkImage(widget.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
    return currentGestureDetector;
  }
}

import 'package:flutter/material.dart';

class GridListIconRow extends StatefulWidget {
  Function resizeParentButtonSize;

  GridListIconRow(this.resizeParentButtonSize, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GridListIconRow();
  }
}

class _GridListIconRow extends State<GridListIconRow> {
  bool isGridMode = false;

  changeToGridMode() {
    setState(() {
      isGridMode = true;
    });
  }

  changeToLineMode() {
    setState(() {
      isGridMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              padding: const EdgeInsets.only(right: 8.0),
              constraints: const BoxConstraints(),
              onPressed: () => {
                    changeToLineMode(),
                    widget.resizeParentButtonSize(isGridMode),
                  },
              icon: const Icon(Icons.menu),
              color: (isGridMode) ? Colors.black : Colors.grey),
          IconButton(
              padding: const EdgeInsets.only(right: 8.0),
              constraints: const BoxConstraints(),
              onPressed: () => {
                    changeToGridMode(),
                    widget.resizeParentButtonSize(isGridMode),
                  },
              icon: const Icon(Icons.grid_view),
              color: (isGridMode) ? Colors.grey : Colors.black),
        ],
      ),
    );
  }
}

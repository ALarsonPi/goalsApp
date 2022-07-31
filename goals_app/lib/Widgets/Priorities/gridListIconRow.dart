import 'package:flutter/material.dart';
import '../../Objects/IconsEnum.dart';

class GridListIconRow extends StatefulWidget {
  Function callParentStateFunction;
  var iconSet;

  GridListIconRow(this.callParentStateFunction, this.iconSet, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GridListIconRow();
  }
}

class _GridListIconRow extends State<GridListIconRow> {
  List<Icon> iconsToShow = List.empty(growable: true);

  @override
  void initState() {
    if (widget.iconSet == IconsEnum.priorityHome) {
      iconsToShow.add(const Icon(Icons.account_balance_wallet));
      iconsToShow.add(const Icon(Icons.list));
    } else if (widget.iconSet == IconsEnum.priorityButtons) {
      iconsToShow.add(const Icon(Icons.menu));
      iconsToShow.add(const Icon(Icons.grid_view));
    }
    super.initState();
  }

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
    Color color1 = Colors.grey;
    Color color2 = Colors.black;
    return Padding(
      padding: EdgeInsets.only(
          right: (widget.iconSet == IconsEnum.priorityButtons) ? 20.0 : 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              padding: const EdgeInsets.only(right: 8.0),
              constraints: const BoxConstraints(),
              onPressed: () => {
                    changeToLineMode(),
                    widget.callParentStateFunction(isGridMode),
                  },
              icon: iconsToShow[0],
              color: (isGridMode) ? color1 : color2),
          IconButton(
              padding: const EdgeInsets.only(right: 8.0),
              constraints: const BoxConstraints(),
              onPressed: () => {
                    changeToGridMode(),
                    widget.callParentStateFunction(isGridMode),
                  },
              icon: iconsToShow[1],
              color: (isGridMode) ? color2 : color1),
        ],
      ),
    );
  }
}

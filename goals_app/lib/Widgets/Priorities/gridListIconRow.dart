import 'package:flutter/material.dart';
import 'package:goals_app/Settings/global.dart';
import '../../Models/IconsEnum.dart';

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
  bool isGridMode = false;

  @override
  void initState() {
    if (widget.iconSet == IconsEnum.priorityHome) {
      isGridMode = Global.priorityIsInListView;
      iconsToShow.add(
        const Icon(
          Icons.account_balance_wallet,
        ),
      );
      iconsToShow.add(const Icon(Icons.list));
    } else if (widget.iconSet == IconsEnum.priorityButtons) {
      isGridMode = Global.goalButtonsInGridView;
      iconsToShow.add(const Icon(Icons.menu));
      iconsToShow.add(const Icon(Icons.grid_view));
    }
    super.initState();
  }

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
    Color? color1 = Theme.of(context).iconTheme.color?.withOpacity(0.3);
    Color color2 = Theme.of(context).textTheme.displaySmall?.color as Color;

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

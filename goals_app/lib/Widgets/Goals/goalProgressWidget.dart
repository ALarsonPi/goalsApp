import 'package:flutter/material.dart';

class GoalProgressWidget extends StatefulWidget {
  String currentAmount;
  String goalAmount;
  Function updateGoal;
  GoalProgressWidget(this.currentAmount, this.goalAmount, this.updateGoal);

  @override
  State<StatefulWidget> createState() {
    return _GoalProgressWidget();
  }
}

class _GoalProgressWidget extends State<GoalProgressWidget> {
  int currentProgress = 0;

  @override
  void initState() {
    currentProgress = int.parse(widget.currentAmount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.flag),
              title: const Text(
                "Progress:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              subtitle: Text(
                "Current: ${currentProgress.toString()}\nGoal: ${widget.goalAmount}",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
            child: Stack(
              children: [
                (currentProgress < int.parse(widget.goalAmount))
                    ? ButtonTheme(
                        height: 1,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        child: TextButton(
                          onPressed: () => {
                            setState(() {
                              currentProgress++;
                              widget.updateGoal(currentProgress.toString());
                            }),
                          },
                          child: const Text(
                            "+",
                            style: TextStyle(height: 1, fontSize: 48),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Column(children: const [
                          Icon(Icons.check,
                              size: 60, color: Colors.greenAccent),
                          Text(
                            "Finished",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          )
                        ]),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

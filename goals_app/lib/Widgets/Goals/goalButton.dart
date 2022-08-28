import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Goal.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualGoalArguments.dart';
import 'package:goals_app/Screens/Goals/individualGoal.dart';
import 'package:goals_app/global.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GoalButton extends StatelessWidget {
  Goal currentGoal;
  bool isGridMode;
  int currPriorityIndex;
  bool isComingFromListView;
  GoalButton(this.currentGoal, this.isGridMode, this.currPriorityIndex,
      this.isComingFromListView,
      {Key? key})
      : super(key: key);

  getRadialIndicator() {
    return GaugeAnnotation(
        positionFactor: 0.1,
        angle: 90,
        widget: (currentGoal.goalProgress != currentGoal.goalTarget)
            ? Text('${currentGoal.goalProgress} / ${currentGoal.goalTarget}',
                style: const TextStyle(fontSize: 11))
            : const Icon(
                Icons.check,
                color: Colors.greenAccent,
                size: 25,
              ));
  }

  getEntireRadialWidget() {
    return SfRadialGauge(
      backgroundColor: Colors.transparent,
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: double.parse(currentGoal.goalTarget),
          showLabels: false,
          showTicks: false,
          annotations: [
            getRadialIndicator(),
          ],
          axisLineStyle: const AxisLineStyle(
            thickness: 0.2,
            cornerStyle: CornerStyle.bothCurve,
            color: Colors.white,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          pointers: <GaugePointer>[
            RangePointer(
              color: Colors.greenAccent,
              value: (double.parse(currentGoal.goalProgress) != 0.0)
                  ? double.parse(currentGoal.goalProgress)
                  : 0.0,
              cornerStyle: CornerStyle.bothCurve,
              width: 0.2,
              sizeUnit: GaugeSizeUnit.factor,
            ),
          ],
        ),
      ],
    );
  }

  goToIndividualGoalScreen(context) {
    Global.depthStack.push(currentGoal);
    Navigator.pushNamed(context, IndividualGoal.routeName,
        arguments: IndividualGoalArguments(
          currentGoal,
          currPriorityIndex,
          isComingFromListView,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return (!isGridMode)
        ? Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 24.0, top: 24.0, bottom: 6.0),
            child: ElevatedButton(
              onPressed: () => {
                goToIndividualGoalScreen(context),
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: (currentGoal.completeByDate == null) ? 125 : 55,
                        width: 125,
                        child: Center(
                          child: Text("Goal: ${currentGoal.name}"),
                        ),
                      ),
                      if (currentGoal.completeByDate != null)
                        SizedBox(
                          height: 35,
                          width: 125,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Finish by:\n ${currentGoal.completeByDate}",
                              style: const TextStyle(
                                  fontSize: 12, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 125,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: getEntireRadialWidget(),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => {
                goToIndividualGoalScreen(context),
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: getEntireRadialWidget(),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(currentGoal.name),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

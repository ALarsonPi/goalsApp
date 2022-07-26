import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Goal.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GoalButton extends StatelessWidget {
  Goal currentGoal;
  bool isGridMode;
  GoalButton(this.currentGoal, this.isGridMode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!isGridMode)
        ? Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 24.0, top: 24.0, bottom: 6.0),
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 125,
                        child: Center(
                          child: Text("Goal: ${currentGoal.name}"),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 125,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SfRadialGauge(
                        backgroundColor: Colors.transparent,
                        axes: <RadialAxis>[
                          RadialAxis(
                            minimum: 0,
                            maximum: 100,
                            showLabels: false,
                            showTicks: false,
                            annotations: [
                              GaugeAnnotation(
                                positionFactor: 0.1,
                                angle: 90,
                                widget: Text(
                                  20.toStringAsFixed(0) + ' / 100',
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ),
                            ],
                            axisLineStyle: const AxisLineStyle(
                              thickness: 0.2,
                              cornerStyle: CornerStyle.bothCurve,
                              color: Colors.white,
                              thicknessUnit: GaugeSizeUnit.factor,
                            ),
                            pointers: const <GaugePointer>[
                              RangePointer(
                                color: Colors.greenAccent,
                                value: 20,
                                cornerStyle: CornerStyle.bothCurve,
                                width: 0.2,
                                sizeUnit: GaugeSizeUnit.factor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => {},
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SfRadialGauge(
                    backgroundColor: Colors.transparent,
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: false,
                        annotations: [
                          GaugeAnnotation(
                            positionFactor: 0.1,
                            angle: 90,
                            widget: Text(
                              20.toStringAsFixed(0) + ' / 100',
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          color: Colors.white,
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: const <GaugePointer>[
                          RangePointer(
                            color: Colors.greenAccent,
                            value: 20,
                            cornerStyle: CornerStyle.bothCurve,
                            width: 0.2,
                            sizeUnit: GaugeSizeUnit.factor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

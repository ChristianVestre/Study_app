import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../Models/TopBarModel.dart';
import '../Blocs/StudyCardStackBloc.dart';
import '../Blocs/BlocProvider.dart';

class ChartWidget extends StatelessWidget {
  final bool animate;
  TopBarChart _topBarChart;

  ChartWidget({ this.animate});



  @override
  Widget build(BuildContext context) {
      StudyCardStackBloc _bloc = BlocProvider.of<StudyCardStackBloc>(context);

    return StreamBuilder<TopBarChart>(
      stream: _bloc.topBarController,
      builder: (BuildContext context, AsyncSnapshot<TopBarChart> snapshot) {
      _topBarChart = snapshot.data;
      if(snapshot.data ==null) return Container();
      List<charts.Series<TopBarData, String>> seriesList =  [
      charts.Series<TopBarData, String>(
        id: 'Easy',
        domainFn: (TopBarData percent, _) => percent._,
        measureFn: (TopBarData percent, _) => percent.percentage,
        data:[TopBarData('',_topBarChart.easy)],
        colorFn: (_ , __) => charts.Color.fromHex(code: "#BEFFEF"),
        labelAccessorFn: (TopBarData percent, _) =>
              (percent.percentage>0.1) ? '${((percent.percentage)).round().toString()}':''
      ),
      charts.Series<TopBarData, String>(
        id: 'Medium',
        domainFn: (TopBarData percent, _) => percent._,
        measureFn: (TopBarData percent, _) => percent.percentage,
        data: [TopBarData('',_topBarChart.medium )],
                colorFn: (_ , __) => charts.Color.fromHex(code: '#F4A0E2'),
        labelAccessorFn: (TopBarData percent, _) =>
              (percent.percentage>0.1) ? '${((percent.percentage)).round().toString()}':''
      ),
      charts.Series<TopBarData, String>(
        id: 'Hard',
        domainFn: (TopBarData percent, _) => percent._,
        measureFn: (TopBarData percent, _) => percent.percentage,
        data: [TopBarData('',_topBarChart.hard ),],
                colorFn: (_ , __) => charts.Color.fromHex(code: '#F0FFF0'),
        labelAccessorFn: (TopBarData percent, _) =>
              (percent.percentage>0.1) ? '${((percent.percentage)).round().toString()}':''
      ),
    ];
        return charts.BarChart(
          seriesList,
          animate: animate,
          vertical: false,

          barRendererDecorator:  charts.BarLabelDecorator(
                    insideLabelStyleSpec: charts.TextStyleSpec(color: charts.Color.black,),
                    labelAnchor: charts.BarLabelAnchor.middle
                    
                    
          ),
          behaviors: [
            charts.PercentInjector(
                totalType: charts.PercentInjectorTotalType.domain)
          ],

          primaryMeasureAxis:
              charts.NumericAxisSpec(renderSpec: charts.NoneRenderSpec()),
              domainAxis: charts.OrdinalAxisSpec(
              showAxisLine: false,
              renderSpec: charts.NoneRenderSpec()),
        );
      }
    );
  }

}


class TopBarData {
  final String _;
  final double percentage;

  TopBarData(this._, this.percentage);
}
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PercentOfDomainBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  PercentOfDomainBarChart(this.seriesList, {this.animate});


  factory PercentOfDomainBarChart.withRandomData() {
    return PercentOfDomainBarChart(_createRandomData());
  }

  static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random =  Random();

    final desktopSalesData = [
       OrdinalSales('2014', random.nextInt(100)),
    ];

    final tableSalesData = [
       OrdinalSales('2014', random.nextInt(100)),
    ];

    final mobileSalesData = [
       OrdinalSales('2014', random.nextInt(100)),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (_ , __) => charts.Color.fromHex(code: "#BEFFEF"),
        labelAccessorFn: (OrdinalSales sales, _) =>
              (sales.sales>10) ? '${sales.sales.toString()}%':''
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
                colorFn: (_ , __) => charts.Color.fromHex(code: '#F4A0E2'),
        labelAccessorFn: (OrdinalSales sales, _) =>
              (sales.sales>10) ? '${sales.sales.toString()}%':''
      ),
      charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
                colorFn: (_ , __) => charts.Color.fromHex(code: '#F0FFF0'),
        labelAccessorFn: (OrdinalSales sales, _) =>
             (sales.sales>10) ? '${sales.sales.toString()}%':''
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      barGroupingType: charts.BarGroupingType.stacked,

      barRendererDecorator:  charts.BarLabelDecorator(
                insideLabelStyleSpec:  charts.TextStyleSpec(color: charts.Color.black,),
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

}


class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
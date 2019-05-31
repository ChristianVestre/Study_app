import 'package:flutter/material.dart';
import '../Blocs/BlocProvider.dart';
import '../Blocs/BottomBarBloc.dart';
import '../Widgets/QuotesWidget.dart';
import '../Widgets/TimerWidget.dart';
import '../Widgets/ChartWidget.dart';

class BottomBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<BottomBarBloc>(context);
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                TabBar(
                  indicatorColor: Colors.black,
                  tabs: [
                    Text('Quotes',style: TextStyle(color: Colors.black),),
                    Text('Timer',style: TextStyle(color: Colors.black),),
                    Text('Charts',style: TextStyle(color: Colors.black),),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Container(child:TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Center(child:QuotesWidget()),
            Center(child: TimerWidget(),),
            Center(child:Container(width: MediaQuery.of(context).size.width / 2, child: ChartWidget()),)
          ],)
        ),
      ),
    );
  }
}

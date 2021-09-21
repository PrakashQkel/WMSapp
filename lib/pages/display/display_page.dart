import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wms_app/MQTTClientWrapper.dart';
import 'package:wms_app/widgets/appbar_title.dart';
import 'package:wms_app/widgets/display_page_dropdown_menu.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class display extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: AppbarTitle(),
            actions: [
              DisplayPageMenu()
            ],
            backgroundColor: Colors.blue[500],
          ),
          body: display_page()
      );
  }
}

class display_page extends StatefulWidget {
  const display_page({Key? key}) : super(key: key);

  @override
  _display_pageState createState() => _display_pageState();
}

class _display_pageState extends State<display_page> {

  int _currentIndex = 0;
  double maxCapacity = 100;
  double maxHeight = 245;
  double level1 = 120, level2 = 155, level3 = 10;
  double flow1 = 3.55, flow2 = 2, flow3 = 5.6;

  var controller = TextEditingController();

  checkMax(double water_level){
    if(water_level>maxCapacity)
      return maxCapacity;
    else return water_level;
  }

  water_level_message(double water_level){
    double newLevel = checkMax(water_level);
    if (newLevel==0)
      return Text(
        'EMPTY',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red
        ),
      );
    if (newLevel==maxCapacity)
      return Text(
        'FULL',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.red
        ),
      );
    if (newLevel < 0.3*maxCapacity)
      return Text(
        'LOW',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.yellow
        ),
      );
    else if (newLevel <= 0.75*maxCapacity)
      return Text(
        'MID',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.orange
        ),
      );
    else if (newLevel < maxCapacity)
      return Text(
        'HIGH',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.green
        ),
      );
  }

  percentage_level(double water_level){
    double newLevel = checkMax(water_level);
    double percentage = newLevel/maxCapacity * 100;
    var percent_string = percentage.toStringAsFixed(0);
    return RichText(
        text: TextSpan(
            children: [
              TextSpan(
                  text: '$percent_string',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              ),
              TextSpan(
                  text: '%',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              )
            ]
        )
    );
  }

  water_tank(int tank_no, double water_level){
    double newLevel = checkMax(water_level);
    var water_level_str = newLevel.toStringAsFixed(1);
    return Expanded(
        child: Row(
          children: [
            Expanded(flex:1, child: Container()),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Tank $tank_no',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 12,
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          //color: Colors.blue[300],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black87, width: 3)
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedContainer(
                            //width: 150,
                            height: water_level/maxCapacity*maxHeight, //max height of tank = 200
                            decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(7)
                            ),
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.easeOut
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  //height: 162,
                  padding: EdgeInsets.only(top: 20, left: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: '$water_level_str',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black
                                      )
                                  ),
                                  TextSpan(
                                      text: 'Ltr',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black
                                      )
                                  )
                                ]
                            )
                        ),
                        percentage_level(water_level),
                        water_level_message(water_level)
                      ],
                    ),
                  ),
                )
            )
          ],
        )
    );
  }

  flow_gauge(int gauge_no, double flow){
    String flowString = flow.toStringAsFixed(2);
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(10),
        child: SfRadialGauge(
          enableLoadingAnimation: false,
          //animationDuration: 2000,
          title: GaugeTitle(
              text: 'Flow $gauge_no'
          ),
          axes: [
            RadialAxis(
              minimum: 0,
              maximum: 10,
              ranges: [
                GaugeRange(
                  startValue: 0,
                  endValue: 3.33,
                  color: Colors.yellow,
                ),
                GaugeRange(
                  startValue: 3.34,
                  endValue: 6.66,
                  color: Colors.green,
                ),
                GaugeRange(
                  startValue: 6.67,
                  endValue: 10.0,
                  color: Colors.red,
                )
              ],
              pointers: [
                NeedlePointer(
                  enableAnimation: true,
                  value: flow,
                  needleStartWidth: 0.5,
                  needleEndWidth: 3,
                  needleColor: Colors.red[300],
                )
              ],
              annotations: [
                GaugeAnnotation(
                  widget: Container(
                      child: Text('$flowString L/min', style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                  angle: 90,
                  positionFactor: 0.3,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  tabs(int tab){
    if(tab==0) {
      return Container(
        color: Colors.blueGrey[100],
        child: Column(
          children: [
            SizedBox(height: 40,),
            water_tank(1, level1),
            SizedBox(height: 40,),
            water_tank(2, level2),
            SizedBox(height: 40,),
          ],
        ),
      );
    }
    else if (tab==1)
      return Container(
        color: Colors.blueGrey[100],
        child: Column(
          children: [
            flow_gauge(1, flow1),
            flow_gauge(2, flow2),
            flow_gauge(3, flow3),
          ],
        ),
      );
    else if (tab==2) {
      return GoogleMap(
        mapToolbarEnabled: false,
        markers: {
          Marker(
              markerId: MarkerId(
                  'Marker1'
              ),
              position: LatLng(27, 89.65),
              infoWindow: InfoWindow(
                  title: 'Ap Dorji\'s Water tank'
              )
          )
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(27.43, 89.65),
            zoom: 17
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<MQTTManager>(context);
    level1 = appState.L1;
    level2 = appState.L2;
    flow1 = appState.F1;
    flow2 = appState.F2;
    flow3 = appState.F3;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: Container(
                  child: tabs(_currentIndex)
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: BottomNavigationBar(
                  enableFeedback: true,
                  currentIndex: _currentIndex,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.blue[500],
                  selectedItemColor: Colors.white,
                  unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  selectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                  onTap: (value){
                    setState(() {
                      _currentIndex = value;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.leaderboard),
                        label: 'Levels'
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.water),
                        label: 'Flow'
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.map),
                        label: 'Maps'
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




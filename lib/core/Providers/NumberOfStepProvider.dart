

import 'dart:async';
import 'dart:convert';
import 'package:ali_muntaser_final_project/core/Model/step.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/step_contant.dart';
import 'package:flutter/widgets.dart';
import 'package:pedometer/pedometer.dart';

class NumberOfStepProvider with ChangeNotifier{


   List<Data> barData = [
    Data(
       name: 'Sun',
       id: 0,
       y: 0,
       color: Color(0xffff4d94),
     ),
    Data(
      id: 1,
      name: 'Mon',
      y: 0,
      color: Color(0xff19bfff),
    ),
    Data(
      name: 'Tue',
      id: 2,
      y: 0,
      color: Color(0xffff4d94),
    ),
    Data(
      name: 'Wed',
      id: 3,
      y: 0,
      color: Color(0xff2bdb90),
    ),
    Data(
      name: 'Thu',
      id: 4,
      y: 0,
      color: Color(0xffffdd80),
    ),
    Data(
      name: 'Fri',
      id: 5,
      y: 0,
      color: Color(0xff2bdb90),
    ),
    Data(
      name: 'Sat',
      id: 6,
      y: 0,
      color: Color(0xffffdd80),
    ),
  ];

   void feachThisWeek()async{

     SharedPreferences prefs = await SharedPreferences.getInstance();
     String jwt= prefs.get('jwt');
     http.Response response=await http.get("https://jaber-server.herokuapp.com/steps/lastWeak",headers: {"x-auth-token":jwt});
     if(response.statusCode==200){
       var result=jsonDecode(response.body) as List;
       for(int i=0;i<result.length;i++){
         setValue(i,result[i]*1.0/1000.0);

       }
       notifyListeners();
       print(response.body);
     }

   }

   void setValue(int index, double value){
     this.barData[index].y=value;
     ///notifyListeners();
   }


  List<StepContant> daliySteps=[];
  int _startTime;






  Timer _timerSeconds;
  int seconds=0;
  int minutes=0;
  int hours=0;
  bool _startTimer=false;
  bool _pause=false;
  bool _end=false;
  int count=0;


  Stream<StepCount> _stepCountStream;

  Stream<PedestrianStatus> _pedestrianStatusStream;

  String _status = 'stopped', _steps = '0';


  String get status => _status;

  ///---------------------------------------------------------------------------

  bool isRunMood(){
    return _startTimer;
  }

  bool isPauseMood(){
    return this._pause;
  }

  bool isEndMood(){
    return this._end;
  }

 ///-----------------------------------------------------------------------------


  void initTimerAndRun()async{
    initPlatformState();

    
   http.Response response=await http.get("https://jaber-server.herokuapp.com/steps/timestamp");
   if(response.statusCode==200){
     _startTime=jsonDecode(response.body)['now'];
   }
    this._startTimer=true;
    this._timerSeconds=Timer.periodic(Duration(seconds: 1), (timer) {

        this.seconds++;
        notifyListeners();
      if(this.seconds==60){
        this.seconds=0;
        this.minutes++;
        if(this.minutes==60){
          minutes=0;
          hours++;
           if(this.hours==24){
             hours=0;
           }
        }
      }

      print(this.seconds);



    });



  }

  void pauseTimer()async{
     this._timerSeconds.cancel();
     this._startTimer=false;
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String jwt= prefs.get('jwt');

     http.Response response=await http.post("https://jaber-server.herokuapp.com/steps",headers: {"x-auth-token":jwt},body: {
       "startTime":"$_startTime",
        "numberOfStep":"$count"
     });

     if(response.statusCode==200){
       print("Aliiiiiiiiiiiiiiiiiiiii");
       feachThisWeek();
     }
     this._timerSeconds.cancel();
     this.seconds=0;
     this.minutes=0;
     this.hours=0;
     this.count=0;
     notifyListeners();
  }

  void killTimer(){
   this._timerSeconds.cancel();
   this.seconds=0;
   this.minutes=0;
   this.hours=0;
   this.count=0;
   // _endTime=5;

   _startTimer=false;
   notifyListeners();
  }

  void onStepCount(StepCount event) {
    print(event);
      this.count++;
      _steps = event.steps.toString();
      notifyListeners();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
      _status = event.status;
      notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');

      _status = 'Pedestrian Status not available';
    notifyListeners();
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
      _steps = 'Step Count not available';
      notifyListeners();
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

  //  if (!mounted) return;
  }

  get steps => _steps;
}

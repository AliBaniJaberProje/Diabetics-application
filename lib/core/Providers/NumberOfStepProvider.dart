

import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:pedometer/pedometer.dart';

class NumberOfStepProvider with ChangeNotifier{

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
  ///

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


  void initTimerAndRun(){
    initPlatformState();

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

  void pauseTimer(){
     this._timerSeconds.cancel();
     this._startTimer=false;
     notifyListeners();
  }

  void killTimer(){
   this._timerSeconds.cancel();
   this.seconds=0;
   this.minutes=0;
   this.hours=0;
   this.count=0;

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

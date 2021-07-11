import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubit/weather_cubit.dart';
import 'package:weatherapp/data/weather_repository.dart';
import 'package:weatherapp/pages/weather_search_pages.dart';


void main() {
  runApp(MaterialApp(
    title: 'Weather App',
    home: BlocProvider(
      create: (context) => WeatherCubit(FakeWeatherRepository()),
      child: WeatherSearchPage(),
    ),
  ));
}






// //ChangeNNotifier is MUTUABLE  

// class MyChangeNotifier extends ChangeNotifier {
//   int? field1;
//   String? field2;

//   void changeState() { 
//     field2 = 'New Value';
//     notifyListeners();
//   }
// }

// //What difference here is that MyState contains the fields and MyCubit contains the
// //the function where as in MyChangeNotifier both the fields and methods in the same class
// //MyChangeNotifier is mutable whereas MyCubit is immutable

// class MyState {
//   final int field1;
//   final String field2;

//   MyState(this.field1, this.field2);
// }

// class MyCubit extends Cubit<MyState> {
//   MyCubit() : super(MyState(0, 'Initial Value'));

//   void changeState() {
//     emit(MyState(0, 'New Value'));//Creating new instance of MyState whenever changeState is called
//   }
// }
// //Cubit holds only the changed state methods

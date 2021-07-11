import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubit/weather_cubit.dart';
import 'package:weatherapp/model/weather.dart';
import 'package:provider/provider.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Search'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<WeatherCubit, WeatherState>(
            // cubit: BlocProvider.of<WeatherCubit>(context),
            listener: (context, state) {
          if (state is WeatherError) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }, builder: (context, state) {
          if (state is WeatherInitial) {
            return buildInitialInput();
          } else if (state is WeatherLoading) {
            return buildLoading();
          } else if (state is WeatherLoaded) {
            return buildColumnWithData(state.weather);
          } else {
            //WeatherError State
            return buildInitialInput();
          }
        }),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return CircularProgressIndicator();
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          "${weather.temperatureCelsius.toStringAsFixed(1)} C",
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final weatherCubit = BlocProvider.of<WeatherCubit>(context);
    weatherCubit.getWeather(cityName);
  }
}

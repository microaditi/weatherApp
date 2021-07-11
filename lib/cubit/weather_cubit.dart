import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/data/weather_repository.dart';
import 'package:weatherapp/model/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  //Dependency Injection
  final WeatherRepository _weatherRepository;
  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}

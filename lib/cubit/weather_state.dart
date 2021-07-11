part of 'weather_cubit.dart';

//STATES:
//INITIAL
//LOADING
//LOADED
//ERROR



@immutable
abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded(this.weather);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is WeatherLoaded && o.weather == weather;
  }

  @override
  int get hashCode => weather.hashCode;

  //Absoultely need to override equality for state classes bcoz otherwise bloc will not emit
  //states that are equal after one another and if you leave referential equality instead of
  //overriding it we can sometimes arrive at a suituation where state will be acting weird
  //and we will not able to understand why a particular state was not emitted.
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is WeatherError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

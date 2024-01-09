// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
      (json['wind']['speed'] as num).toDouble(),
      dt: json['dt'] as int,
      temp: (json['main']['temp'] as num).toDouble(),
      feels_like: (json['main']['feels_like'] as num).toDouble(),
      temp_min: (json['main']['temp_min'] as num).toDouble(),
      temp_max: (json['main']['temp_max'] as num).toDouble(),
      pressure: json['main']['pressure'] as int,
      sea_level: json['main']['sea_level'] as int,
      grnd_level: json['main']['grnd_level'] as int,
      humidity: json['main']['humidity'] as int,
      temp_kf: (json['main']['temp_kf'] as num).toDouble(),
    );

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
      'pressure': instance.pressure,
      'sea_level': instance.sea_level,
      'grnd_level': instance.grnd_level,
      'humidity': instance.humidity,
      'temp_kf': instance.temp_kf,
      'wind_speed': instance.wind_speed,
    };

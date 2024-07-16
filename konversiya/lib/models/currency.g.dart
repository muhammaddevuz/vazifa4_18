// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      code: json['code'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'code': instance.code,
      'value': instance.value,
    };

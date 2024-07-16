import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable()
class Currency {
  String code;
  double value;

  Currency({required this.code, required this.value});

  factory Currency.fromJson(Map<String, dynamic> json) {
    return _$CurrencyFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CurrencyToJson(this);
  }
}

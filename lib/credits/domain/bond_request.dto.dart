import 'package:phoneplus/shared/infraestructure/utils/serializable.dart';

class GracePeriod {
  int period;
  int type;
  GracePeriod({required this.period, required this.type});
  Map<String, dynamic> toJson() => {'Period': period, 'Type': type};
}

class BondRequest with Serializable {
  double? commercialValue;
  double? nominalValue;
  double? structurationRate;
  double? colonRate;
  double? flotationRate;
  double? cavaliRate;
  double? primRate;
  int? numberOfYears;
  int? frequencies;
  int? dayPerYear;
  int? capitalizationTypes;
  int? userId;
  double? cuponRate;
  int? cuponRateType;
  int? cuponRateFrequency;
  int? cuponRateCapitalization;
  int? currency;
  List<GracePeriod>? gracePeriods;
  int? id;

  BondRequest({
    this.id,
    this.commercialValue,
    this.nominalValue,
    this.structurationRate,
    this.colonRate,
    this.flotationRate,
    this.cavaliRate,
    this.primRate,
    this.numberOfYears,
    this.frequencies,
    this.dayPerYear,
    this.capitalizationTypes,
    this.userId,
    this.cuponRate,
    this.cuponRateType,
    this.cuponRateFrequency,
    this.cuponRateCapitalization,
    this.currency,
    this.gracePeriods,
  });

  @override
  Map<String, dynamic> toRequest() {
    return {
      'id': id,
      'comercialValue': commercialValue,
      'nominalValue': nominalValue,
      'structurationRate': structurationRate,
      'colonRate': colonRate,
      'flotationRate': flotationRate,
      'cavaliRate': cavaliRate,
      'primRate': primRate,
      'numberOfYears': numberOfYears,
      'frequencies': frequencies,
      'dayPerYear': dayPerYear,
      'capitalizationTypes': capitalizationTypes,
      'userId': userId,
      'cuponRate': cuponRate,
      'cuponRateType': cuponRateType,
      'cuponRateFrequency': cuponRateFrequency,
      'cuponRateCapitalization': cuponRateCapitalization,
      'currency': currency,
      'gracePeriods': gracePeriods?.map((e) => e.toJson()).toList(),
    };
  }
}

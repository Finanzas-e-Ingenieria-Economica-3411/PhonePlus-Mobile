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
  int? yearDiscount;
  double? rentImport;
  int? userId;
  double? cuponRate;
  int? cuponRateType;
  int? cuponRateFrequency;
  int? cuponRateCapitalization;
  int? currency;
  List<GracePeriod>? gracePeriods;

  BondRequest({
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
    this.yearDiscount,
    this.rentImport,
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
      'ComercialValue': commercialValue,
      'NominalValue': nominalValue,
      'StructurationRate': structurationRate,
      'ColonRate': colonRate,
      'FlotationRate': flotationRate,
      'CavaliRate': cavaliRate,
      'PrimRate': primRate,
      'NumberOfYears': numberOfYears,
      'Frequencies': frequencies,
      'DayPerYear': dayPerYear,
      'CapitalizationTypes': capitalizationTypes,
      'YearDiscount': yearDiscount,
      'RentImport': rentImport,
      'UserId': userId,
      'CuponRate': cuponRate,
      'CuponRateType': cuponRateType,
      'CuponRateFrequency': cuponRateFrequency,
      'CuponRateCapitalization': cuponRateCapitalization,
      'Currency': currency,
      'GracePeriods': gracePeriods?.map((e) => e.toJson()).toList(),
    };
  }
}

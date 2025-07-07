import 'package:phoneplus/shared/infraestructure/utils/serializable.dart';

class BondRequest with Serializable {
  double? nominalValue;
  double? commercialValue;
  double? couponRate;
  double? marketRate;
  int? periods;
  String? currency;
  String? rateType;
  String? capitalization;
  double? structuringFee;
  double? placementFee;
  double? flotationFee;
  double? cavaliFee;
  double? redemptionPremium;
  int? gracePeriods;
  String? issueDate;
  int? userId;
  String? state;

  BondRequest({
    this.nominalValue,
    this.commercialValue,
    this.couponRate,
    this.marketRate,
    this.periods,
    this.currency,
    this.rateType,
    this.capitalization,
    this.structuringFee,
    this.placementFee,
    this.flotationFee,
    this.cavaliFee,
    this.redemptionPremium,
    this.gracePeriods,
    this.issueDate,
    this.userId,
    this.state,
  });

  @override
  Map<String, dynamic> toRequest() {
    return {
      'nominalValue': nominalValue,
      'commercialValue': commercialValue,
      'couponRate': couponRate,
      'marketRate': marketRate,
      'periods': periods,
      'currency': currency,
      'rateType': rateType,
      'capitalization': capitalization,
      'structuringFee': structuringFee,
      'placementFee': placementFee,
      'flotationFee': flotationFee,
      'cavaliFee': cavaliFee,
      'redemptionPremium': redemptionPremium,
      'gracePeriods': gracePeriods,
      'issueDate': issueDate,
      'userId': userId,
      'state': state,
    };
  }
}


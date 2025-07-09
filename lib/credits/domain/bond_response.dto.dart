class BondResponseDto {
  int? id;
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
  String? issuerName;
  String? username;
  double? tcea;
  double? trea;
  double? duration;
  double? modifiedDuration;
  double? convexity;
  double? maxPrice;
  List<dynamic>? cashFlow;

  BondResponseDto({
    this.id,
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
    this.issuerName,
    this.username,
    this.tcea,
    this.trea,
    this.duration,
    this.modifiedDuration,
    this.convexity,
    this.maxPrice,
    this.cashFlow,
  });

  BondResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nominalValue = _toDouble(json['nominalValue']);
    commercialValue = _toDouble(json['comercialValue']);
    couponRate = _toDouble(json['cuponRate']);
    marketRate = null;

    periods = json['numberOfYears'];

    currency = _mapCurrency(json['currency']);
    rateType = _mapRateType(json['cuponRateType']);
    capitalization = _mapCapitalization(json['capitalizationTypes']);

    structuringFee = _toDouble(json['structurationRate']);
    placementFee = null; // No viene en JSON
    flotationFee = _toDouble(json['flotationRate']);
    cavaliFee = _toDouble(json['cavaliRate']);
    redemptionPremium = _toDouble(json['primRate']);

    gracePeriods = (json['gracePeriods'] as List).length;
    issueDate = null; // No viene en JSON

    userId = json['userId'];
    state = _mapState(json['state']);

    issuerName = json['clientName'];
    username = json['username'];

    tcea = null;
    trea = null;
    duration = null;
    modifiedDuration = null;
    convexity = null;
    maxPrice = null;
    cashFlow = [];
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    return double.tryParse(value.toString());
  }

  static String? _mapCurrency(int? value) {
    if (value == null) return null;
    switch (value) {
      case 1:
        return 'PEN';
      case 2:
        return 'USD';
      default:
        return 'UNKNOWN';
    }
  }

  static String? _mapRateType(int? value) {
    if (value == null) return null;
    switch (value) {
      case 1:
        return 'Efectiva';
      case 2:
        return 'Nominal';
      default:
        return 'UNKNOWN';
    }
  }

  static String? _mapCapitalization(int? value) {
    if (value == null) return null;
    switch (value) {
      case 1:
        return 'Diaria';
      case 2:
        return 'Quincenal';
      case 3:
        return 'Mensual';
      case 4:
        return 'Bimestral';
      case 5:
        return 'Trimestral';
      case 6:
        return 'Semestral';
      case 7:
        return 'Anual';
      default:
        return 'UNKNOWN';
    }
  }

  static String? _mapState(int? value) {
    if (value == null) return null;
    return value == 1 ? 'Activo' : 'Inactivo';
  }
}

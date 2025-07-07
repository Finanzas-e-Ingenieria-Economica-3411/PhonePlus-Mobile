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
  // Result fields
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
    nominalValue = json['nominalValue'];
    commercialValue = json['commercialValue'];
    couponRate = json['couponRate'];
    marketRate = json['marketRate'];
    periods = json['periods'];
    currency = json['currency'];
    rateType = json['rateType'];
    capitalization = json['capitalization'];
    structuringFee = json['structuringFee'];
    placementFee = json['placementFee'];
    flotationFee = json['flotationFee'];
    cavaliFee = json['cavaliFee'];
    redemptionPremium = json['redemptionPremium'];
    gracePeriods = json['gracePeriods'];
    issueDate = json['issueDate'];
    userId = json['userId'];
    state = json['state'];
    issuerName = json['issuerName'];
    username = json['username'];
    tcea = json['tcea'];
    trea = json['trea'];
    duration = json['duration'];
    modifiedDuration = json['modifiedDuration'];
    convexity = json['convexity'];
    maxPrice = json['maxPrice'];
    cashFlow = json['cashFlow'];
  }
}


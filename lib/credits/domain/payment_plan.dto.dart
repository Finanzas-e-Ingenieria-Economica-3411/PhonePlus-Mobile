class PaymentPlanDto {
  double? tcea;
  double? trea;
  double? duration;
  double? modifiedDuration;
  double? convexity;
  double? maxMarketPrice;
  List<double>? cashFlows;

  PaymentPlanDto({
    this.tcea,
    this.trea,
    this.duration,
    this.modifiedDuration,
    this.convexity,
    this.maxMarketPrice,
    this.cashFlows,
  });

  PaymentPlanDto.fromJson(Map<String, dynamic> json) {
    tcea = _toDouble(json['tcea']);
    trea = _toDouble(json['trea']);
    duration = _toDouble(json['duration']);
    modifiedDuration = _toDouble(json['modifiedDuration']);
    convexity = _toDouble(json['convexity']);
    maxMarketPrice = _toDouble(json['maxMarketPrice']);

    if (json['cashFlows'] != null) {
      cashFlows = (json['cashFlows'] as List)
          .map((e) => _toDouble(e) ?? 0.0)
          .toList();
    } else {
      cashFlows = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['tcea'] = tcea;
    data['trea'] = trea;
    data['duration'] = duration;
    data['modifiedDuration'] = modifiedDuration;
    data['convexity'] = convexity;
    data['maxMarketPrice'] = maxMarketPrice;
    data['cashFlows'] = cashFlows;
    return data;
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}

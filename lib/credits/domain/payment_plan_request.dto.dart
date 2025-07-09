import 'package:phoneplus/shared/infraestructure/utils/serializable.dart';

class PaymentPlanRequestDto with Serializable {
  int? creditId;
  double? cokValue;
  int? cokType;
  int? cokFrequency;
  int? cokCapitalization;

  PaymentPlanRequestDto(
      {this.creditId,
        this.cokValue,
        this.cokType,
        this.cokFrequency,
        this.cokCapitalization});


  @override
  Map<String, dynamic> toRequest() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creditId'] = creditId;
    data['cokValue'] = cokValue;
    data['cokType'] = cokType;
    data['cokFrequency'] = cokFrequency;
    data['cokCapitalization'] = cokCapitalization;
    return data;
  }
}

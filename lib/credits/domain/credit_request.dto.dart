import 'package:phoneplus/shared/infraestructure/utils/serializable.dart';

class CreditRequest with Serializable {
  int? phoneNumber;
  double? price;
  String? startDate;
  int? months;
  double? interestRate;
  int? insurance;
  int? amortization;
  int? paid;
  int? interest;
  int? pendingPayment;
  int? userId;

  CreditRequest({
    this.phoneNumber,
    this.price,
    this.startDate,
    this.months,
    this.interestRate,
    this.insurance,
    this.amortization,
    this.paid,
    this.interest,
    this.pendingPayment,
    this.userId,
  });

  @override
  Map<String, dynamic> toRequest() {
    return {
      'phoneNumber': phoneNumber,
      'price': price,
      'startDate': startDate,
      'months': months,
      'interestRate': interestRate,
      'insurance': insurance,
      'amortization': amortization,
      'paid': paid,
      'interest': interest,
      'pendingPayment': pendingPayment,
      'userId': userId,
    };
  }
}

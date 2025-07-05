class CreditResponseDto {
  int? id;
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
  String? clientName;
  String? username;
  int? stateId;

  CreditResponseDto(
      {this.id,
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
        this.clientName,
        this.username,
        this.stateId});

  CreditResponseDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    price = json['price'];
    startDate = json['startDate'];
    months = json['months'];
    interestRate = json['interestRate'];
    insurance = json['insurance'];
    amortization = json['amortization'];
    paid = json['paid'];
    interest = json['interest'];
    pendingPayment = json['pendingPayment'];
    clientName = json['clientName'];
    username = json['username'];
    stateId = json['stateId'];
  }

}
import 'package:flutter/material.dart';
import 'package:phoneplus/credits/domain/credit_request.dto.dart';
import 'package:phoneplus/credits/infrastructure/service/credit.service.dart';

class CreditProvider extends ChangeNotifier {
  Future<void> createCredit(CreditRequest request) async {
    try {
      final service = CreditService();
      await service.createCredit(request);
    } catch (e) {
      throw Exception(e);
    }
  }
}


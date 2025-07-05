import 'package:flutter/material.dart';
import 'package:phoneplus/credits/domain/credit_request.dto.dart';
import 'package:phoneplus/credits/domain/credit_response.dto.dart';
import 'package:phoneplus/credits/infrastructure/service/credit.service.dart';

class CreditProvider extends ChangeNotifier {
  List<CreditResponseDto> _credits = [];
  get credits => _credits;
  get creditNumber => _credits.length;
  Future<void> createCredit(CreditRequest request) async {
    try {
      final service = CreditService();
      await service.createCredit(request);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getAvailableCredits() async {
    try {
      final service = CreditService();
      final response =  await service.getAll();
      print("Holaaaaaa");
      print(response);
      _credits = response.map((json) => CreditResponseDto.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print('nooooo');
      print(e);
      throw Exception(e);
    }
  }
}


import 'package:flutter/material.dart';
import 'package:phoneplus/credits/domain/bond_request.dto.dart';
import 'package:phoneplus/credits/domain/bond_response.dto.dart';
import 'package:phoneplus/credits/domain/payment_plan.dto.dart';
import 'package:phoneplus/credits/domain/payment_plan_request.dto.dart';
import 'package:phoneplus/credits/infrastructure/service/bond.service.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';

class BondProvider extends ChangeNotifier {
  List<BondResponseDto> _bonds = [];
  PaymentPlanDto? _paymentPlan;
  get bonds => _bonds;
  get bondNumber => _bonds.length;
  get paymentPlans => _paymentPlan;
  Future<void> createBond(BondRequest request) async {
    try {
      final service = BondService();
      await service.createBond(request);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getAvailableBonds() async {
    try {
      final service = BondService();
      final response = await service.getAll();
      _bonds = response.map((json) => BondResponseDto.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> getMyBonds() async {
    try {
      final service = BondService();
      final userId = await StorageHelper.getUserId();
      final response = await service.getByParam("/user?userId=${userId.toString()}");
      _bonds = response.map((json) => BondResponseDto.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }



  Future<void> updateBond(int id, BondRequest request) async {
    try {
      final service = BondService();
      await service.updateBond(id, request);
      await getAvailableBonds();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> calculatePaymentPlan(int creditId, double? cokValue, int? cokType,int? cokFrequency,int? cokCapitalization) async{
    try {
      final service = BondService();
      final request = PaymentPlanRequestDto(creditId: creditId,cokValue: cokValue,cokType: cokType,cokFrequency: cokFrequency, cokCapitalization: cokCapitalization);
      _paymentPlan = await service.requestPaymentPlant(request);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}

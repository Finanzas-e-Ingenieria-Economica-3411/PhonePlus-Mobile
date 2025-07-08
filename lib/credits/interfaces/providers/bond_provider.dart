import 'package:flutter/material.dart';
import 'package:phoneplus/credits/domain/bond_request.dto.dart';
import 'package:phoneplus/credits/domain/bond_response.dto.dart';
import 'package:phoneplus/credits/infrastructure/service/bond.service.dart';

class BondProvider extends ChangeNotifier {
  List<BondResponseDto> _bonds = [];
  get bonds => _bonds;
  get bondNumber => _bonds.length;
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

  Future<void> updateBond(int id, BondRequest request) async {
    try {
      final service = BondService();
      await service.updateBond(id, request);
      await getAvailableBonds();
    } catch (e) {
      throw Exception(e);
    }
  }
}

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
      // TODO: Reemplazar este mock por la llamada real al backend cuando esté listo
      // final service = BondService();
      // final response =  await service.getAll();
      // _bonds = response.map((json) => BondResponseDto.fromJson(json)).toList();
      // notifyListeners();
      _bonds = [
        BondResponseDto(
          id: 1,
          nominalValue: 1000.0,
          commercialValue: 950.0,
          couponRate: 0.08,
          marketRate: 0.09,
          periods: 5,
          currency: 'PEN',
          rateType: 'Efectiva',
          capitalization: 'Anual',
          structuringFee: 0.01,
          placementFee: 0.01,
          flotationFee: 0.005,
          cavaliFee: 0.002,
          redemptionPremium: 0.01,
          gracePeriods: 0,
          issueDate: '2025-07-07T00:00:00.000Z',
          userId: 1,
          state: 'active',
          issuerName: 'Empresa S.A.',
          username: 'emisor1',
          tcea: 0.095,
          trea: 0.085,
          duration: 4.2,
          modifiedDuration: 4.0,
          convexity: 18.5,
          maxPrice: 980.0,
          cashFlow: [
            -950.0, 80.0, 80.0, 80.0, 80.0, 1080.0
          ],
        ),
        BondResponseDto(
          id: 2,
          nominalValue: 2000.0,
          commercialValue: 2100.0,
          couponRate: 0.07,
          marketRate: 0.065,
          periods: 3,
          currency: 'USD',
          rateType: 'Nominal',
          capitalization: 'Semestral',
          structuringFee: 0.012,
          placementFee: 0.009,
          flotationFee: 0.004,
          cavaliFee: 0.002,
          redemptionPremium: 0.0,
          gracePeriods: 0,
          issueDate: '2025-08-01T00:00:00.000Z',
          userId: 2,
          state: 'active',
          issuerName: 'Empresa B',
          username: 'emisor2',
          tcea: 0.068,
          trea: 0.072,
          duration: 2.7,
          modifiedDuration: 2.6,
          convexity: 7.9,
          maxPrice: 2050.0,
          cashFlow: [
            -2100.0, 140.0, 140.0, 2140.0
          ],
        ),
      ];
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}

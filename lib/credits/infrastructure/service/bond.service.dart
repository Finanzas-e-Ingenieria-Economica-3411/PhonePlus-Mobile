import 'package:phoneplus/credits/domain/bond_request.dto.dart';
import 'package:phoneplus/shared/infraestructure/service/base_service.dart';

class BondService extends BaseService<BondRequest> {
  BondService() : super(resourcePath: 'bond');

  Future<dynamic> createBond(BondRequest request) async {
    try {
      final response = await post(request);
      return response;
    } catch (e) {
      throw Exception('Error creating bond: $e');
    }
  }

  Future<void> updateBond(int id, BondRequest request) async {
    try {
      await put(id, request);
    } catch (e) {
      throw Exception('Error updating bond: $e');
    }
  }
}

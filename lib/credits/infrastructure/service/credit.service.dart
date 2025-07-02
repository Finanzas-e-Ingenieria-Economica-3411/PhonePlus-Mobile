import 'package:phoneplus/credits/domain/credit_request.dto.dart';
import 'package:phoneplus/shared/infraestructure/service/base_service.dart';

class CreditService extends BaseService<CreditRequest> {
  CreditService() : super(resourcePath: 'credit');

  Future<dynamic> createCredit(CreditRequest request) async {
    try {
      final response = await post(request);
      return response;
    } catch (e) {
      throw Exception('Error creating credit: $e');
    }
  }
}


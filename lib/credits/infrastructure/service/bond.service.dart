import 'package:dio/src/response.dart';
import 'package:phoneplus/core/constants/constant.dart';
import 'package:phoneplus/credits/domain/bond_request.dto.dart';
import 'package:phoneplus/credits/domain/payment_plan.dto.dart';
import 'package:phoneplus/credits/domain/payment_plan_request.dto.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/shared/infraestructure/service/base_service.dart';

class BondService extends BaseService {
  BondService() : super(resourcePath: 'credit');

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
      await patchCustom("credit/edit", request);
    } catch (e) {
      throw Exception('Error updating bond: $e');
    }
  }

  Future<PaymentPlanDto> requestPaymentPlant(PaymentPlanRequestDto request) async {
    try {
      final token = await StorageHelper.getToken();
      print(request.toRequest());
      dio.options.headers["Authorization"] = "Bearer $token";
      print(dio.options.headers);
      final response = await dio.post( "${Constant.baseUrl}credit/payment-plan", data: request.toRequest());
      final data = response.data;
      return PaymentPlanDto.fromJson(data);
    } catch (e) {
      print(e);
      throw Exception("Error while trying to request $e");
    }
  }

}

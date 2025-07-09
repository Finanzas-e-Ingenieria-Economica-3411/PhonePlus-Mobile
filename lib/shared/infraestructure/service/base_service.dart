import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../core/constants/constant.dart';
import '../../interfaces/it/locators/logger_locator.dart';
import '../helpers/storage_helper.dart';
import '../utils/serializable.dart';

abstract class BaseService<TRequest extends Serializable>{
  final  Dio _dio;
  final Logger logger = getIt<Logger>();
  final String token ="";
  String resourcePath;
  Dio get dio => _dio;

  BaseService({
    required this.resourcePath,
  }) : _dio = Dio(BaseOptions(
    baseUrl: Constant.baseUrl,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  Future<String> getToken() async {
    return await StorageHelper.getToken() ?? "";
  }

  Future<List<dynamic>> getAll() async {
    try {
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final response = await _dio.get(Constant.baseUrl + resourcePath, options: options);
      final List<dynamic> data = response.data;
      return data;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<List<dynamic>> getByParam(String query) async {
    try {
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      print(Constant.baseUrl + resourcePath + query);
      final response = await _dio.get(Constant.baseUrl + resourcePath + query, options: options);
      final List<dynamic> data = response.data;
      return data;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    } catch (e){
      throw Exception("Unknown exception: $e");
    }
  }


  Future<dynamic> post(TRequest request) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final response = await _dio.post(Constant.baseUrl + resourcePath, data: request.toRequest(), options: options);
      return response.data;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling POST ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<bool> put(int id, TRequest request) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      await _dio.patch("${Constant.baseUrl}$resourcePath/$id", data: request.toRequest(), options: options);
      return true;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling PUT ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<bool> delete(int id) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      await _dio.delete("${Constant.baseUrl}$resourcePath/$id", options: options);
      return true;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling DELETE ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<Map<String,dynamic>> getById(int id) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final response = await _dio.get("${Constant.baseUrl}$resourcePath/$id", options: options);
      final data = response.data;
      return data;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling GET BY ID ${Constant.baseUrl}$resourcePath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

  Future<bool> patchCustom(String customPath, TRequest request) async {
    try{
      final token = await getToken();
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      await _dio.patch("${Constant.baseUrl}$customPath", data: request.toRequest(), options: options);
      return true;
    } on DioException catch (e){
      final statusCode = e.response?.statusCode;
      logger.log(
        Level.error,
        'Error while calling PATCH ${Constant.baseUrl}$customPath, status code: $statusCode, message: ${e.message}',
      );
      throw Exception('HTTP Error: $statusCode');
    }catch (e){
      throw Exception("Unknown exception: $e");
    }
  }

}
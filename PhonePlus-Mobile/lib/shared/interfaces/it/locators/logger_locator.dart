import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

void setUpLoggerLocator(){
  getIt.registerLazySingleton(() => Logger());

}
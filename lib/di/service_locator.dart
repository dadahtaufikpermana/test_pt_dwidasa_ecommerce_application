import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:test_pt_dwidasa_ecommerce_app/di/repository_module.dart';
import 'package:test_pt_dwidasa_ecommerce_app/network/dio_client.dart';
import '../env/env.dart';
import '../repositories/products_repository.dart';
import 'bloc_module.dart';
import 'endpoint_module.dart';

final locator = GetIt.instance;

Future<bool?> getItInit(Env env) async {
  _setupDefaultDio(env.baseUrl, env.token);
  await registerEndPoints();
  await registerRepositories();
  await registerBlocs();
  return null;
}

void _setupDefaultDio(String baseUrl, String token) {
  locator.registerLazySingleton<Dio>(() => DioClient.build(baseUrl, token));
  locator.registerLazySingleton<ProductsRepository>(() => ProductsRepository(locator<Dio>()));
}

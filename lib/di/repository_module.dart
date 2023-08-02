
import '../repositories/products_repository.dart';
import 'service_locator.dart';

Future<void> registerRepositories() async {
  locator.registerFactory(() => ProductsRepository(locator()));
}

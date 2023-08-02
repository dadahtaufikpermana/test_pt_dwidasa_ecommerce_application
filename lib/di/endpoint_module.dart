import '../network/endpoints/products_endpoint.dart';
import 'service_locator.dart';

Future<void> registerEndPoints() async {
  locator.registerFactory(() => ProductsEndpoint());
}

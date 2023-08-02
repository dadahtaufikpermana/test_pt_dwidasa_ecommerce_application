import '../ui/products/bloc/product_cubit.dart';
import 'service_locator.dart';

Future<void> registerBlocs() async {
  locator.registerFactory(() => ProductCubit(locator(), ));
}

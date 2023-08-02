import 'package:bloc/bloc.dart';
import '../../../models/response/product_entity.dart';
import '../../../repositories/products_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductsRepository _productsRepository;

  ProductCubit(this._productsRepository) : super(ProductInitial()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    if (state is! ProductInitial) {
      return;
    }
    emit(ProductInitial());
    try {
      final List<ProductEntity> products = await _productsRepository.getAllProducts();
      emit(ProductsUpdated(products));
    } catch (error) {
      emit(ProductLoadError('Failed to load products: $error'));
    }
  }


  Future<void> loadProductById(int id) async {
    if (state is ProductInitial || state is ProductsUpdated) {

      emit(ProductInitial());
      try {
        final ProductEntity product = await _productsRepository.getProductById(id);
        emit(ProductLoaded(product));
      } catch (error) {
        emit(ProductLoadError('Failed to load product: $error'));
      }
    }
  }

}


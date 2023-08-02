import 'package:dio/dio.dart';
import '../models/response/product_entity.dart';
import '../network/endpoints/products_endpoint.dart';

class ProductsRepository {
  final Dio _dio;
  final ProductsEndpoint _productsEndpoint;

  ProductsRepository(this._dio) : _productsEndpoint = ProductsEndpoint();

  Future<List<ProductEntity>> getAllProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');
      final List<dynamic> jsonData = response.data;
      return jsonData.map((data) => ProductEntity.fromJson(data)).toList();
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }

  Future<ProductEntity> getProductById(int id) async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products/$id');
      return ProductEntity.fromJson(response.data);
    } catch (e) {
      print('Error fetching product by ID: $e');
      throw Exception('Failed to load product');
    }
  }

}

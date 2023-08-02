import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../models/response/product_entity.dart';

@JsonSerializable()
class ProductsEndpoint {
  final Dio _dio = Dio();

  Future<List<ProductEntity>> getAllProduct() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData.map((data) => ProductEntity.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<ProductEntity> getProductById(int id) async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products/$id');
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = response.data;
        return ProductEntity.fromJson(jsonData);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

}

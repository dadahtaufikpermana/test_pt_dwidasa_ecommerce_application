import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pt_dwidasa_ecommerce_app/models/response/product_entity.dart';
import 'package:test_pt_dwidasa_ecommerce_app/ui/products/bloc/product_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadProductById();
  }

  @override
  void didUpdateWidget(ProductDetailPage oldWidget) {
    if (widget.productId != oldWidget.productId) {
      _loadProductById();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _loadProductById() {
    BlocProvider.of<ProductCubit>(context).loadProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              "Product Detail",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            return _buildProductDetail(state.product);
          } else if (state is ProductLoadError) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            );
          }
          return const Center(
            child: Text("Something went wrong"),
          );
        },
      ),
    );
  }

  Widget _buildProductDetail(ProductEntity product) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, o, s) => Container(color: Colors.grey[200]),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Category: ${product.category}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Price: \$${product.price}",
                style: const TextStyle(fontSize: 18, color: Colors.blue),
              ),
              const SizedBox(height: 16),
              Text(
                "Description:",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                "Rating: ${product.rating.rate}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.grey,
                size: 26,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

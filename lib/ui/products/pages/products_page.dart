import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:test_pt_dwidasa_ecommerce_app/common/utils/ui_utils.dart';
import 'package:test_pt_dwidasa_ecommerce_app/models/response/product_entity.dart';
import 'package:test_pt_dwidasa_ecommerce_app/ui/products/bloc/product_cubit.dart';
import 'package:test_pt_dwidasa_ecommerce_app/ui/products/pages/product_detail_page.dart';
import '../../../common/widgets/pagination_grid_view.dart';
import '../../../repositories/products_repository.dart';
import '../widgets/item_card.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductsRepository _productsRepository = ProductsRepository(Dio());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(_productsRepository),
      child: Scaffold(
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
                "Shopping Mall",
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
        body: BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductsUpdated && state.error != null) {
              context.showSnackbar(state.error!);
            }
          },
          builder: (context, state) {
            if (state is ProductInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsUpdated) {
              return PaginationGridView<ProductEntity>(
                padding: const EdgeInsets.all(20),
                items: state.products,
                itemBuilder: (context, item) {
                  return InkWell(
                    onTap: () {
                      if (item.id != null && item.id != 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              productId: item.id!,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Invalid product ID'),
                          ),
                        );
                      }
                    },
                    child: ItemCard(entity: item),
                  );
                },
                onScrolledToBottom: () {
                  BlocProvider.of<ProductCubit>(context).loadProducts();
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  mainAxisExtent: 285,
                  maxCrossAxisExtent: 220,
                ),
              );
            } else if (state is ProductLoadError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.error,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<ProductCubit>(context).loadProducts();
                      },
                      child: const Text("Retry"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.2)),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text("Something went wrong"),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.orange,
          unselectedItemColor: Colors.grey,
          currentIndex: 0,
          onTap: (index) {
            if (index == 1) {
            } else {}
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: IconButton(onPressed: () {}, icon: const Icon(Icons.table_rows_sharp)),
            ),
            BottomNavigationBarItem(
              label: "Favorite",
              icon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite),
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
            ),
          ],
        ),
      ),
    );
  }
}


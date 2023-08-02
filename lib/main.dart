import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_pt_dwidasa_ecommerce_app/repositories/products_repository.dart';
import 'package:test_pt_dwidasa_ecommerce_app/ui/products/bloc/product_cubit.dart';
import 'app/routes.dart';
import 'di/service_locator.dart';
import 'env/env.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool?>(
      future: getItInit(Env.prod()),
      builder: (context, s) {
        print(s.connectionState.toString());
        return s.connectionState == ConnectionState.done
            ? MultiBlocProvider(
          providers: [
            BlocProvider<ProductCubit>(
              create: (context) => ProductCubit(ProductsRepository(Dio())),
            ),
            // Add other BlocProviders if needed
          ],
          child: MaterialApp(
            title: 'Shopping Mall',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.blue,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.blue[300],
              ),
            ),
            initialRoute: Routes.splashScreen,
            onGenerateRoute: RouteGenerator.builder,
          ),
        )
            : Container(
          color: Colors.white,
        );
      },
    );
  }
}


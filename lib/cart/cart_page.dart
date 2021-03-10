import 'package:cart_hive/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito pro"),
      ),
      body: BlocProvider(
        create: (context) => CartBloc()..add(LoadProductsEvent()),
        child: BlocConsumer<CartBloc, CartState>(
          listener: (context, state) {
            if (state is ElementRemovedState) {
              // show snackbar
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Error"),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is ElementsLoadedState) {
              //TODO: borrar
              return Text("TODO");
            } else
              return Center(
                child: Text("No hay elementos"),
              );
          },
        ),
      ),
    );
  }
}

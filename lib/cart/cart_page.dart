import 'package:cart_hive/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cart_bloc.dart';

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
            if (state is ElementRemovingState) {
              // show snackbar
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Borrando..."),
                  ),
                );
            }
          },
          builder: (context, state) {
            if (state is ElementsLoadedState) {
              return ListView.builder(
                itemCount: state.prodsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key("$index"),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        BlocProvider.of<CartBloc>(context).add(
                          RemoveProductEvent(element: index),
                        );
                      }
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete),
                      alignment: Alignment.centerLeft,
                    ),
                    child: ListTile(
                      title: Text("${state.prodsList[index].name}"),
                      subtitle: Text("${state.prodsList[index].price}"),
                    ),
                  );
                },
              );
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greggsproject/src/data/models/product_model.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_bloc.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_states.dart';

import 'package:greggsproject/src/presentation/views/cart_screen.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
      List<Map<int,ProductModel>> cartItems = state.cartItems ?? [];

      return Stack(
        children: [
          IconButton(
            icon: Icon(Icons.shopping_bag),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
          ),
          if (cartItems.length > 0)
            Align(
              child: Container(
                child: Text(
                  '${cartItems.length}',
                  style: TextStyle(color: Colors.white),
                ),
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                padding: EdgeInsets.all(4),
              ),
              alignment: Alignment.topRight,
            )
        ],
      );
    });
  }
}

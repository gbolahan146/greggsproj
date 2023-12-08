import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greggsproject/src/data/models/product_model.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_bloc.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_events.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_states.dart';
import 'package:greggsproject/src/presentation/bloc/product/product_bloc.dart';
import 'package:greggsproject/src/presentation/views/widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(create: (context) => ProductBloc())
      ],
      child: Scaffold(
          persistentFooterButtons: [
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Checkout time!',
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: (Colors.blue),
                  action: SnackBarAction(
                    label: 'dismiss',
                    onPressed: () {},
                  ),
                ));
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                constraints: BoxConstraints(minWidth: 169),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'Checkout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1,
                      decoration: TextDecoration.none),
                ),
              ),
            )
          ],
          appBar: AppBar(
            title: Text('Checkout'),
            actions: [CartIcon()],
          ),
          body: BlocBuilder<CartBloc, CartStates>(builder: (context, state) {
            List<Map<int,ProductModel>> cartItems = state.cartItems ?? [];
            return cartItems.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Center(
                          child: Text(
                              'Cart is empty\n Add more items to checkout',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20)),
                        )
                      ])
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text('Cart Items:'),
                        SizedBox(height: 8),
                        Text('*Swipe to delete*',
                            style: TextStyle(fontSize: 12)),
                        SizedBox(height: 8),
                        SizedBox(height: 24),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2,
                          child: Scrollbar(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: cartItems.length,
                              separatorBuilder: (c, i) => Divider(
                                thickness: 1,
                                color: Colors.grey[200],
                              ),
                              itemBuilder: (context, index) => Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                onDismissed: (DismissDirection direction) {},
                                confirmDismiss:
                                    (DismissDirection direction) async {
                                  final confirmed = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            'Are you sure you want to delete this item from cart?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                              BlocProvider.of<CartBloc>(context)
                                                  .add(RemoveProductEvent(
                                                      id: cartItems[index].keys.first
                                                          ));
                                              setState(() {});
                                            },
                                            child: const Text('Yes'),
                                          )
                                        ],
                                      );
                                    },
                                  );

                                  return confirmed;
                                },
                                background: const ColoredBox(
                                  color: Colors.red,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.grey[200] ?? Colors.grey),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Container(
                                        color: Colors.grey[200],
                                        child: Image.network(
                                          cartItems[index].values.first.imageUri ?? "",
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${cartItems[index].values.first.articleName}"),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                              "£${cartItems[index].values.first.eatInPrice}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Quantity:',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500)),
                                  Text('${cartItems.length}',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Price:',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500)),
                                  Text('£${totalPRice(cartItems)}',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          })),
    );
  }

  String? totalPRice(List<Map<int,ProductModel>>? cart) {

    if (cart == null || cart.isEmpty) {
      return "0"; // Return null if the requests list is null or empty
    }

    num sum = 0;

    for (var item in cart) {
      sum += item.values.first.eatInPrice ?? 0; // Add the indPrice of each item to the sum

    }

    return sum.toStringAsFixed(2);

  }
}

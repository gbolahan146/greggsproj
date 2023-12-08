import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greggsproject/src/data/models/product_model.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_bloc.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_events.dart';
import 'package:greggsproject/src/presentation/bloc/product/product_bloc.dart';
import 'package:greggsproject/src/presentation/bloc/product/product_events.dart';
import 'package:greggsproject/src/presentation/bloc/product/product_states.dart';

import 'package:greggsproject/src/presentation/views/widgets.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  int id = 1;

  ProductModel? currentProd;
  late AnimationController addToCartPopUpAnimationController;

  @override
  void initState() {
    addToCartPopUpAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    super.initState();
  }

  @override
  void dispose() {
    addToCartPopUpAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(create: (context) => ProductBloc())
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text('Product details'),
            actions: [CartIcon()],
          ),
          persistentFooterButtons: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    addToCartPopUpAnimationController.forward();
                    Timer(const Duration(seconds: 3), () {
                      addToCartPopUpAnimationController.reverse();
                    });

                    BlocProvider.of<CartBloc>(context)
                        .add(AddProductEvent(product: {id: currentProd!}));
                    id++;
                    setState(() {});
                  },
                  child: Text("Add to Cart",
                      style: TextStyle(color: Colors.white))),
            )
          ],
          body: Stack(
            children: [
              BlocProvider<ProductBloc>(
                  create: (context) => ProductBloc()..add(FetchProductEvent()),
                  child: BlocBuilder<ProductBloc, ProductStates>(
                      builder: (context, state) {
                    if (state is DataLoadingState) {
                      return CircularProgressIndicator();
                    }

                    if (state is DataErrorState) {
                      return Text("Error fetching product");
                    }
                    if (state is ProductLoadedState) {
                      currentProd = state.product;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                decoration:
                                    BoxDecoration(color: Colors.grey[100]),
                                // padding:EdgeInsets.symmetric(horizontal: 16),
                                child: Image.network(
                                    state.product?.imageUri ?? "")),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(state.product?.shopCode ?? "",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                      Container(
                                          child: Icon(Icons.favorite_border,
                                              size: 12, color: Colors.black54),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.grey),
                                          ),
                                          padding: EdgeInsets.all(4))
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(state.product?.articleName ?? "",
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500)),
                                      Text.rich(TextSpan(
                                          text:
                                              "£${state.product?.eatInPrice ?? ""}",
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                          children: [
                                            TextSpan(
                                              text:
                                                  '(£${state.product?.eatOutPrice ?? ""})',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ])),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  SizedBox(
                                      width: 120,
                                      height: 20,
                                      child: ListView.builder(
                                          itemCount: 5,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) => const Icon(
                                              Icons.star,
                                              color: Colors.yellow))),
                                  SizedBox(height: 16),
                                  Text(
                                      "Avaibility: ${DateFormat('hh:mm a').format(DateTime.parse(state.product?.availableFrom ?? ""))} - ${DateFormat('hh:mm a').format(DateTime.parse(state.product?.availableUntil ?? ""))}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(height: 16),
                                  Text(
                                      "${state.product?.customerDescription ?? ""}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  SizedBox(height: 8),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return SizedBox();
                  })),
              addToCartPopUp(),
            ],
          )),
    );
  }

  addToCartPopUp() {
    return SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(addToCartPopUpAnimationController),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 12,
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(Icons.add_shopping_cart),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Successfully added to cart",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Text(
                              "Go to cart",
                              style: TextStyle(
                                color: Color(0xff535960),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                          onTap: () {
                            addToCartPopUpAnimationController.reverse();
                          },
                          child: const Icon(Icons.cancel)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

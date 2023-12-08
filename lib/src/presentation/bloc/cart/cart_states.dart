import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:greggsproject/src/data/models/product_model.dart';

@immutable
abstract class CartStates extends Equatable {
  final List<Map<int,ProductModel>>? cartItems;
  CartStates({
    this.cartItems,
  });
  
  
}

class DataLoadingState extends CartStates {
  @override
  List<Object?> get props => [];
}

// cart
class InitialCartData extends CartStates {
  final List<Map<int,ProductModel>>? products;

  InitialCartData({this.products});

  @override
  List<Object?> get props => [products];
}

class CartLoadedState extends CartStates {
  final List<Map<int,ProductModel>>? cartItems;

  CartLoadedState({this.cartItems});
  @override
  List<Object?> get props => [cartItems];
}

class DataErrorState extends CartStates {
  final String error;

  DataErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

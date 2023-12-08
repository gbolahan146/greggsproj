import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:greggsproject/src/data/models/product_model.dart';

@immutable
abstract class ProductStates extends Equatable {}

class DataLoadingState extends ProductStates {
  @override
  List<Object?> get props => [];
}

// product

class ProductLoadedState extends ProductStates {
  final ProductModel? product;

  ProductLoadedState({this.product});
  @override
  List<Object?> get props => [product];
}

// cart
class InitialProductState extends ProductStates {
  final ProductModel? product;

  InitialProductState({this.product});

  @override
  List<Object?> get props => [product];
}



class DataErrorState extends ProductStates {
  final String error;

  DataErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:greggsproject/src/data/models/product_model.dart';

@immutable
abstract class CartEvents extends Equatable {
  // const TestEvents();
}

class AddProductEvent extends CartEvents {
  final Map<int, ProductModel>? product;

  AddProductEvent({this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveProductEvent extends CartEvents {
  final int? id;

  RemoveProductEvent({this.id});

  @override
  List<Object> get props => [id ?? ""];
}

class InitialEvent extends CartEvents {
  @override
  List<Object?> get props => [];
}

class FetchCartEvent extends CartEvents {
  @override
  List<Object?> get props => [];
}

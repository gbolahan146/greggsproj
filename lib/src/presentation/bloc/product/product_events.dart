import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class ProductEvents extends Equatable {
  // const TestEvents();
}

class InitialEvent extends ProductEvents {
  @override
  List<Object?> get props => [];
}

class FetchProductEvent extends ProductEvents {

  @override
  List<Object?> get props => [];
}

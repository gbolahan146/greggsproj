import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greggsproject/src/data/models/product_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:greggsproject/src/presentation/bloc/product/product_events.dart';
import 'package:greggsproject/src/presentation/bloc/product/product_states.dart';

class ProductBloc extends Bloc<ProductEvents, ProductStates> {
  ProductBloc() : super(InitialProductState()) {
   

    on<FetchProductEvent>((event, emit) async {
      emit(DataLoadingState());
      final String jsonString =
          await rootBundle.loadString('assets/product.json');

      // Future.delayed(Duration(seconds: 2), () {
      emit(ProductLoadedState(
          product: ProductModel.fromJson(jsonDecode(jsonString))));
      // });
    });
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greggsproject/src/data/models/product_model.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_events.dart';
import 'package:greggsproject/src/presentation/bloc/cart/cart_states.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  CartBloc() : super(InitialCartData(products: [])) {
    on<AddProductEvent>(
      (event, emit) async {
        // emit(DataLoadingState());
        try {
          // Future.delayed(Duration(seconds: 2), () {
          _cartItems.add(event.product!);
          emit(CartLoadedState(
            cartItems: _cartItems,
          ));

          // });

        } catch (e) {
          emit(DataErrorState(e.toString()));
        }
      },
    );
    on<RemoveProductEvent>((event, emit) {
      _cartItems.removeWhere((e) => e.keys.first == event.id);
      emit(CartLoadedState(cartItems: _cartItems));
    });
  }

  final List<Map<int, ProductModel>> _cartItems = [];
  List<Map<int, ProductModel>> get items => _cartItems;
}

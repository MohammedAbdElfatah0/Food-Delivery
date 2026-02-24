import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/model/product_model.dart';
import 'package:food_delivery/features/home/presentation/cubit/product/product.status.dart';

import '../../../../../core/utils/error/failures.dart';
import '../../../domain/usecase/get_all_product.dart';
import '../../../domain/usecase/get_product_by_category.dart';

class ProductCubit extends Cubit<ProductStatus> {
  ProductCubit(this._getAllProduct, this._getProductByCategory)
    : super(ProductInit());

  final GetAllProduct _getAllProduct;
  final GetProductByCategory _getProductByCategory;

  Future<void> _loadProducts(
    Future<Either<Failure, List<ProductModel>>> Function() loader,
  ) async {
    emit(ProductLoading());

    final result = await loader();

    result.fold(
      (l) => emit(ProductError(message: l.message)),
      (r) => emit(ProductSuccess(products: r)),
    );
  }

  //1-method get all products
  Future<void> getAllProducts() async {
    //loading
    //get all products from repository
    //success
    //error

    try {
      emit(ProductLoading());
      await _loadProducts(() => _getAllProduct());
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }

  //2-method get products by category
  Future<void> getProductsByCategory(String category) async {
    try {
      emit(ProductLoading());
      await _loadProducts(() => _getProductByCategory(category));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}

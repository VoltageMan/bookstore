import 'package:bookstore.tm/models/api/paginated_data_model.dart';
import 'package:bookstore.tm/models/cart/cart_product_model/cart_product_model.dart';

abstract class FavorsRepo {
  Future<PaginatedDataModel<List<CartProductModel>>?> getFavors(int page);
  Future<bool?> switchFavor(int id);
}

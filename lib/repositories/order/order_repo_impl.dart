import 'package:bookstore.tm/data/remote/dio_client.dart';
import 'package:bookstore.tm/models/api/paginated_data_model.dart';
import 'package:bookstore.tm/models/cart/cart_model/cart_model.dart';
import 'package:bookstore.tm/models/order_history/order_history_model.dart';
import 'package:bookstore.tm/models/pagination/pagination_model.dart';
import 'package:bookstore.tm/repositories/order/order_repo.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderRepo)
class OrderRepoImpl extends OrderRepo with DioClientMixin {
  @override
  Future<PaginatedDataModel<List<OrderHistoryModel>>?> getOrderHistory(
      int page) async {
    final response = await dio
        .get(endPoint: EndPoints.orderHistory, queryParameters: {'page': page});

    if (response.success) {
      final responseData = response.data[APIKeys.history];
      final pagination =
          PaginationModel.fromJson(responseData[APIKeys.pagination]);

      ///
      final orders = (responseData[APIKeys.data] as List)
          .map((e) => OrderHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return PaginatedDataModel<List<OrderHistoryModel>>(
        data: orders,
        pagination: pagination,
      );
    }
    return null;
  }

  Future<CartModel?> getDetails(String uuid) async {
    final response = await dio.get(endPoint: EndPoints.cartFetch(uuid));
    if (response.success) {
      return CartModel.fromJson(response.data[APIKeys.cart]);
    }
    return null;
  }
}

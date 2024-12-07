import 'package:dio/dio.dart';
import 'package:bookstore.tm/features/terms_of_usage/usage_terms_model.dart';
import 'package:bookstore.tm/models/product_details/product_details_model.dart';
import 'package:bookstore.tm/models/state/state_model.dart';

abstract class ProductRepo {
  Future<Map<String, dynamic>?> getProducts({
    required List<String> slugs,
    required List<int> properties,
    required int page,
    String? search,
    int? videoId,
  });
  Future<StateModel?> getDeliveryInfo();
  Future<List<String>?> getFeedBack();
  Future<UsageTermsModel?> getTermsOfUsage();
  Future<ProductDetailsModel?> getDetails(int id, CancelToken cancelToken);
}

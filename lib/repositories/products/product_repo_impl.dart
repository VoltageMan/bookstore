import 'package:dio/dio.dart';
import 'package:bookstore.tm/data/remote/dio_client.dart';
import 'package:bookstore.tm/features/terms_of_usage/usage_terms_model.dart';
import 'package:bookstore.tm/models/pagination/pagination_model.dart';
import 'package:bookstore.tm/models/product_details/product_details_model.dart';
import 'package:bookstore.tm/models/products/product_model.dart';
import 'package:bookstore.tm/models/state/state_model.dart';
import 'package:bookstore.tm/repositories/products/product_repo.dart';
import 'package:bookstore.tm/settings/consts.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRepo)
class ProductRepoImpl extends ProductRepo with DioClientMixin {
  @override
  Future<ProductDetailsModel?> getDetails(
      int id, CancelToken cancelToken) async {
    final response = await dio.get(
      endPoint: EndPoints.prodDetails(id),
      cancelToken: cancelToken,
    );
    if (response.success) {
      return ProductDetailsModel.fromJson(Map.from(response.data));
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> getProducts({
    required List<String> slugs,
    required List<int> properties,
    required int page,
    String? search,
    int? videoId,
  }) async {
    final response = await dio.get(
      endPoint: _endPoint(slugs, properties, page, videoId),
      queryParameters: search != null ? {'search': search} : null,
    );
    if (response.success) {
      // converting paginationModel from json
      final data = response.data[APIKeys.products];
      final pagination = PaginationModel.fromJson(data[APIKeys.pagination]);

      // converting productList from json
      final products = (data[APIKeys.data] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return {
        APIKeys.pagination: pagination,
        APIKeys.products: products,
      };
    }
    return null;
  }

  @override
  Future<StateModel?> getDeliveryInfo() async {
    final response = await dio.get(endPoint: EndPoints.deliveryInfo);
    if (response.success) {
      return StateModel.fromMap(response.data);
    }
    return null;
  }

  @override
  Future<UsageTermsModel?> getTermsOfUsage() async {
    final response = await dio.get(endPoint: EndPoints.termsOfUsage);
    if (response.success) {
      return UsageTermsModel.fromMap(response.data[APIKeys.termsOfUsage]);
    }
    return null;
  }

  @override
  Future<List<String>?> getFeedBack() async {
    final response = await dio.get(endPoint: EndPoints.feedBack);
    if (response.success) {
      return (response.data[APIKeys.feedBack] as List)
          .map((e) => e as String)
          .toList();
    }
    return null;
  }

  String _endPoint(
      List<String> slugs, List<int> properties, int page, int? videoId) {
    final videoParam = videoId == null ? '' : '&video_id=$videoId';
    if (slugs.isEmpty && properties.isEmpty) {
      return '${EndPoints.products}?${APIKeys.page}=$page$videoParam';
    }
    List<String> slugList = List.empty();
    List<String> propertyList = List.empty();

    if (slugs.isNotEmpty) {
      slugList = List.generate(
        slugs.length,
        (index) {
          return '${APIKeys.categories}${APIKeys.urlDecoder}=${slugs[index]}$videoParam';
        },
      );
    }
    if (properties.isNotEmpty) {
      propertyList = List.generate(
        properties.length,
        (index) {
          return '${APIKeys.properties}${APIKeys.urlDecoder}=${properties[index]}$videoParam';
        },
      );
    }
    final propertiesUrl = propertyList.join('&');
    final slugsUrl = slugList.join('&');
    final joiner = propertiesUrl.isNotEmpty && slugsUrl.isNotEmpty ? '&' : '';
    return '${EndPoints.products}?$propertiesUrl$joiner$slugsUrl&${APIKeys.page}=$page$videoParam';
  }
}

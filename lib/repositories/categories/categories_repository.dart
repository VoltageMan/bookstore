import 'dart:async';
import 'package:dio/dio.dart';
import 'package:bookstore.tm/models/categories/category_model.dart';

abstract class CategoryRepo {
  Future<Map<String, List<CategoryModel>>?> getAll();
  Future<List<CategoryModel>> getAssetMains();
  Future<Map<String, List<CategoryModel>>?> getSubsBySlug(
      String slug, CancelToken cancleToken);
}

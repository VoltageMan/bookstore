import 'package:bookstore/models/property/property_model.dart';

abstract class FilterRepo {
  Future<List<PropertyModel>?> getProps();
}

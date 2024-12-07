import 'package:bookstore.tm/models/property/property_model.dart';

abstract class FilterRepo {
  Future<List<PropertyModel>?> getProps();
}

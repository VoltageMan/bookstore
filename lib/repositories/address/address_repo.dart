import 'package:bookstore.tm/models/addres/address_model.dart';

abstract class AddressRepo {
  Future<AddressModel?> create(String address);
  Future<AddressModel?> update(AddressModel model);
  Future<AddressModel?> fetch(String address);
  Future<Map<String, dynamic>?> read(int page);
}

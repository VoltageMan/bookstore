// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:bookstore/models/cart/cart_order_model/cart_order_model.dart';

part 'cart_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CartModel extends Equatable {
  CartModel({
    required this.stateHistory,
    required this.uuid,
    required this.total,
    required this.subTotal,
    required this.weightCost,
    required this.deliveryCost,
    required this.date,
    required this.status,
    required this.statusTrans,
    this.code = ' ',
    this.orders = const [],
  });
  final String uuid;
  final String code;
  final String total;
  final String subTotal;
  final String weightCost;
  final String deliveryCost;
  final String date;
  final String status;
  final String statusTrans;
  final List<CartOrderModel> orders;
  final List<OrderStateModel> stateHistory;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return _$CartModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  @override
  List<Object?> get props => [
        uuid,
        total,
        subTotal,
        weightCost,
        deliveryCost,
        orders,
        status,
        stateHistory,
        statusTrans
      ];

  //!
}

class OrderStateModel {
  OrderStateModel({
    required this.state,
    this.completed_at,
  });
  final String? completed_at;
  final String state;
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'state': state,
      'completed_at': completed_at,
    };
  }

  factory OrderStateModel.fromJson(Map<String, dynamic> map) {
    return OrderStateModel(
      state: map['state'] as String,
      completed_at:
          map['completed_at'] != null ? map['completed_at'] as String : null,
    );
  }
}



// "data": {
//     "cart": {
//       "uuid": "9a6e9bc2-c655-4ad5-a94f-09d66c4a82b8",
//       "total": "2606.6",
//       "delivery_cost": "50",
//       "weight_cost": "5",
//       "sub_total": "2661.6",
//       "status": "PENDING",
//       "status_trans": "PENDING",
//       "date": "04.11.2023",
//       "state_history": [
//         {
//           "state": "PENDING",
//           "completed_at": null
//         },
//         {
//           "state": "CONFIRMED",
//           "completed_at": null
//         },
//         {
//           "state": "PREPARING",
//           "completed_at": null
//         },
//         {
//           "state": "DELIVERING",
//           "completed_at": null
//         },
//         {
//           "state": "ARRIVED",
//           "completed_at": null
//         },
//         {
//           "state": "COMPLETED",
//           "completed_at": null
//         }
//       ],
//       "orders": [
//         {
//           "id": "9a8831a0-cbd4-448e-a790-428bd0cc08a2",
//           "total": "506.6",
//           "quantity": 1,
//           "property_values": [],
//           "purchase": {
//             "id": 1,
//             "name": "Kadın Pantolonu",
//             "description": "Kadın pamuk elastik kısaltılmış Uniqlo pantolon (ayarlanabilir bel ile gündelik havuç pantolon",
//             "sale_price": "506.6",
//             "price": "506.6",
//             "discount_price": null,
//             "images": "http://216.250.9.74/storage/22544/2.jpg",
//             "is_favorite": false
//           }
//         },
//         {
//           "id": "9a75ba5d-c4a6-41fc-b334-6d0aece390bd",
//           "total": "2100",
//           "quantity": 10,
//           "property_values": [],
//           "purchase": {
//             "id": 81,
//             "name": "Four Seasons Ayakkabı",
//             "description": "Çapraz -border Business Casual Deri Ayakkabı Dört Seasons, Erkekler Resmi Deri Ayakkabıları, Erkek İş Ayakkabıları Çok Büyük, Şık ve Pratik",
//             "sale_price": "210",
//             "price": "210",
//             "discount_price": null,
//             "images": "http://216.250.9.74/storage/22867/1.jpg",
//             "is_favorite": false
//           }
//         }
//       ]
//     }
//   }

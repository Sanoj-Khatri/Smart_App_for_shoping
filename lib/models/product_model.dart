import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? productId;
  String? mart;
  String? productCompany;
  String? productName;
  String? productImage;
  String? productPrice;
  String? productWeight;
  List<Map<String, String>>? reviews;

  ProductModel({
    this.productId,
    this.mart,
    this.productCompany,
    this.productName,
    this.productImage,
    this.productPrice,
    this.productWeight,
    this.reviews,
  });

  ProductModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    productId = doc.id;
    mart = doc['mart'];
    productCompany = doc['product_company'];
    productName = doc['product_name'];
    productImage = doc['product_pic'];
    productPrice = doc['product_price'];
    productWeight = doc['product_weight'];
    reviews = doc.data()!.containsKey("reviews") ? doc['reviews'] : [];
  }
}

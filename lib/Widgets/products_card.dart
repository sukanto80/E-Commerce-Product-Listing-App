import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'color_manager.dart';

class GridProductCard extends StatefulWidget {
  final String? imageUrl;
  final String? title;
  final double? price;
  final double? rating;
  final String? category;
  final int? stock;
  final int? id;
  final double? discount;



  const GridProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.rating,
    required this.category,
    required this.id,
    required this.stock,
    required this.discount,
  });

  @override
  State<GridProductCard> createState() => _GridProductCardState();
}

class _GridProductCardState extends State<GridProductCard> {

  bool showCounter = false;

  Color myBackgroundColor = AppColor.fromHex("#d4d4dc");

  double calculateDiscountedPrice(double originalPrice, double discountPercentage) {
    double discountedPrice = originalPrice * (1 - discountPercentage / 100);
    return discountedPrice;
  }
  @override
  Widget build(BuildContext context) {
   // double screenHeight = MediaQuery.of(context).size.height;
   // double imageHeight = screenHeight < 700 ? 140 : 120; // adjust as needed
    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(12),
        //border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  color: myBackgroundColor
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    widget.imageUrl!,
                    width: double.infinity,
                    height: 164,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    color: Colors.white
                  ),
                  child: Icon(
                    Icons.favorite_outline,
                    color: Colors.black45,
                    size: 17,
                  ),
                ),
              ),
              //if (index == 3)
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Out Of Stock",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  widget.title!,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "\$60 ",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$75",
                      style: TextStyle(
                        fontSize: 11,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      "25% OFF",
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text("4.8", style: TextStyle(fontSize: 11)),
                    Text(" (692)", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

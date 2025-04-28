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
    final discountedPrice = calculateDiscountedPrice(widget.price ?? 0, widget.discount ?? 0);

    return Container(
      decoration: BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                  color: myBackgroundColor,
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl!,
                    width: double.infinity,
                    height: 164,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(color: Colors.grey.shade300),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.favorite_outline,
                    color: Colors.black45,
                    size: 17,
                  ),
                ),
              ),
              if (widget.stock == 0) //  Show Out of Stock only when stock = 0
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisAlignment: MainAxisAlignment.spaceBetween, // <--- Adjust spacing nicely
                children: [
                  Text(
                    widget.title ?? '',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          "\$${discountedPrice.toStringAsFixed(2)} ",
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        if (widget.discount != null && widget.discount! > 0)
                          Row(
                            children: [
                              Text(
                                "\$${widget.price?.toStringAsFixed(2) ?? ''}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${widget.discount?.toInt()}% OFF",
                                style: const TextStyle(fontSize: 10,
                                    color: Colors.red),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),



                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${widget.rating?.toStringAsFixed(1) ?? '0.0'}",
                        style: const TextStyle(fontSize: 11),
                      ),
                      Text(
                        " (${widget.stock ?? 0})",
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

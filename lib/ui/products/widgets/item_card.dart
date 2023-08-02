import 'package:flutter/material.dart';
import '../../../models/response/product_entity.dart';

class ItemCard extends StatefulWidget {
  final ProductEntity entity;

  const ItemCard({Key? key, required this.entity}) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                child: Center(
                  child: Image.network(
                    widget.entity.image,
                    errorBuilder: (context, o, s) =>
                        Container(color: Colors.grey[200]),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.entity.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text("\$${widget.entity.price}"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      "${widget.entity.rating.rate}",
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : Colors.grey,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

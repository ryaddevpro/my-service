import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_service/pages/services/detail/detail_page.dart';

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productDescription;
  final double rating;
  final int index;

  ServiceCard({
    required this.imageUrl,
    required this.productName,
    required this.productDescription,
    required this.rating,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailPage(
              imageUrl: imageUrl,
              productName: productName,
              productDescription: productDescription,
              rating: rating,
            ),
          ),
        );
      },
      child: Card(
        elevation: 8,
        child: Row(
          children: <Widget>[
            Hero(
              tag: '${productName}_$index',
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Image.network(
                  imageUrl,
                  height: 125.0,
                  width: 125.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(4),
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      productDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                    RatingBarIndicator(
                      rating: rating,
                      itemCount: 5,
                      itemSize: 20.0,
                      direction: Axis.horizontal,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

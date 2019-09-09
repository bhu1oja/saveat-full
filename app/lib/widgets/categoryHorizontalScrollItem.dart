import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saveat/utils/theme.dart' as AppTheme;

class CategoryHorizontalScrollItem extends StatefulWidget {
  String categoryImage;
  String categoryName;

  CategoryHorizontalScrollItem({this.categoryImage, this.categoryName});

  @override
  _CategoryHorizontalScrollItemState createState() =>
      _CategoryHorizontalScrollItemState();
}

class _CategoryHorizontalScrollItemState
    extends State<CategoryHorizontalScrollItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              child: CachedNetworkImage(
                imageUrl: widget.categoryImage,
                fit: BoxFit.fill,
                height: 80,
                width: 120,
                placeholder: (context, url) => Center(
                      child: Container(
                        alignment: Alignment.center,
                        color: AppTheme.Colors.grayTwo,
                        child: CircularProgressIndicator(
                          backgroundColor: AppTheme.Colors.primaryColor,
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error)),
              ),
            ),
            Text(widget.categoryName)
          ],
        ),
      ),
    );
  }
}

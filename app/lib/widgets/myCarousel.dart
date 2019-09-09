import 'package:flutter/material.dart';
import 'package:saveat/utils/theme.dart' as AppTheme;
import 'package:cached_network_image/cached_network_image.dart';

class MyCarousel {
  myCarousel(cheight) {
    return Container(
      height: cheight / 3,
      child: PageView(
        children: <Widget>[
          Container(
            child: CachedNetworkImage(
              imageUrl:
                  "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80",
              fit: BoxFit.cover,
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
          Container(
            child: CachedNetworkImage(
              imageUrl:
                  "https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
              fit: BoxFit.cover,
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
          Container(
            child: CachedNetworkImage(
              imageUrl:
                  "https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
              fit: BoxFit.cover,
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
        ],
      ),
    );
  }
}

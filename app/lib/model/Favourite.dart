class Favourite {
  final String userID;
  final String productID;
  final String productName;
  final String productImage;
  final String productPrice;
  final String productDiscountPrice;
  final bool liked;

  Favourite(this.userID, this.productID, this.productName, this.productImage,
      this.productPrice, this.productDiscountPrice, this.liked);
}

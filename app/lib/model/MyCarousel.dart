class MyCarouselModel {
  final String name;
  final String image;

  MyCarouselModel({this.name, this.image});

  factory MyCarouselModel.fromJson(Map<String, dynamic> json) {
    return MyCarouselModel(
        name: json['name'] as String, image: json['categoryImage'] as String);
  }
}

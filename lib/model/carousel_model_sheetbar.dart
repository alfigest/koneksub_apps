class CarouselModel {
  String? image;

  CarouselModel(this.image);
}

List<CarouselModel?> carousels =
    carouselListData.map((item) => CarouselModel(item['image'])).toList();

var carouselListData = [
  {"image": "assets/introduction_sheet/carousel_flight_discount.png"},
  {"image": "assets/introduction_sheet/carousel_hotel_discount.png"},
  {"image": "assets/introduction_sheet/carousel_covid_discount.png"}
];

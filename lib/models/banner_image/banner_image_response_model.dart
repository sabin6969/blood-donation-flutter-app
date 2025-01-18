class BannerImageResponseModel {
  BannerImageResponseModel({
    required this.statusCode,
    required this.message,
    required this.sucess,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final bool? sucess;
  final List<Datum> data;

  factory BannerImageResponseModel.fromJson(Map<String, dynamic> json) {
    return BannerImageResponseModel(
      statusCode: json["statusCode"],
      message: json["message"],
      sucess: json["sucess"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  Datum({
    required this.id,
    required this.imageUrl,
    required this.v,
  });

  final String? id;
  final String? imageUrl;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      imageUrl: json["imageUrl"],
      v: json["__v"],
    );
  }
}

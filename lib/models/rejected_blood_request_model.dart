class RejectedBloodRequestModel {
  RejectedBloodRequestModel({
    required this.statusCode,
    required this.message,
    required this.sucess,
    required this.data,
  });

  final int? statusCode;
  final String? message;
  final bool? sucess;
  final List<Datum> data;

  factory RejectedBloodRequestModel.fromJson(Map<String, dynamic> json) {
    return RejectedBloodRequestModel(
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
    required this.requestedBy,
    required this.isApproved,
    required this.isReviewed,
    required this.note,
    required this.requestedBloodGroup,
    required this.city,
    required this.hospital,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? requestedBy;
  final bool? isApproved;
  final bool? isReviewed;
  final String? note;
  final String? requestedBloodGroup;
  final String? city;
  final String? hospital;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"],
      requestedBy: json["requestedBy"],
      isApproved: json["isApproved"],
      isReviewed: json["isReviewed"],
      note: json["note"],
      requestedBloodGroup: json["requestedBloodGroup"],
      city: json["city"],
      hospital: json["hospital"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

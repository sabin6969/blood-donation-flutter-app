class CampaignResponseModel {
    CampaignResponseModel({
        required this.statusCode,
        required this.message,
        required this.sucess,
        required this.data,
    });

    final int? statusCode;
    final String? message;
    final bool? sucess;
    final List<Datum> data;

    factory CampaignResponseModel.fromJson(Map<String, dynamic> json){ 
        return CampaignResponseModel(
            statusCode: json["statusCode"],
            message: json["message"],
            sucess: json["sucess"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.campaignName,
        required this.date,
        required this.time,
        required this.isCampaignActive,
        required this.campaignOrganizedBy,
        required this.location,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.noOfParticipants,
        required this.isAlreadyRegistered,
    });

    final String? id;
    final String? campaignName;
    final String? date;
    final String? time;
    final bool? isCampaignActive;
    final CampaignOrganizedBy? campaignOrganizedBy;
    final Location? location;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;
    final int? noOfParticipants;
    final bool? isAlreadyRegistered;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"],
            campaignName: json["campaignName"],
            date: json["date"],
            time: json["time"],
            isCampaignActive: json["isCampaignActive"],
            campaignOrganizedBy: json["campaignOrganizedBy"] == null ? null : CampaignOrganizedBy.fromJson(json["campaignOrganizedBy"]),
            location: json["location"] == null ? null : Location.fromJson(json["location"]),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
            v: json["__v"],
            noOfParticipants: json["noOfParticipants"],
            isAlreadyRegistered: json["isAlreadyRegistered"],
        );
    }

}

class CampaignOrganizedBy {
    CampaignOrganizedBy({
        required this.fullName,
        required this.email,
        required this.phoneNumber,
        required this.bloodGroup,
        required this.role,
        required this.imageUrl,
        required this.isAvailableForDonation,
        required this.v,
    });

    final String? fullName;
    final String? email;
    final String? phoneNumber;
    final String? bloodGroup;
    final String? role;
    final String? imageUrl;
    final bool? isAvailableForDonation;
    final int? v;

    factory CampaignOrganizedBy.fromJson(Map<String, dynamic> json){ 
        return CampaignOrganizedBy(
            fullName: json["fullName"],
            email: json["email"],
            phoneNumber: json["phoneNumber"],
            bloodGroup: json["bloodGroup"],
            role: json["role"],
            imageUrl: json["imageUrl"],
            isAvailableForDonation: json["isAvailableForDonation"],
            v: json["__v"],
        );
    }

}

class Location {
    Location({
        required this.type,
        required this.coordinates,
    });

    final String? type;
    final List<double> coordinates;

    factory Location.fromJson(Map<String, dynamic> json){ 
        return Location(
            type: json["type"],
            coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x)),
        );
    }

}

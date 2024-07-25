class CampaignResponse {
  int? statusCode;
  String? message;
  bool? sucess;
  List<Data>? data;

  CampaignResponse({this.statusCode, this.message, this.sucess, this.data});

  CampaignResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    sucess = json['sucess'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['sucess'] = sucess;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? campaignName;
  String? date;
  String? time;
  bool? isCampaignActive;
  CampaignOrganizedBy? campaignOrganizedBy;
  Location? location;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.campaignName,
      this.date,
      this.time,
      this.isCampaignActive,
      this.campaignOrganizedBy,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    campaignName = json['campaignName'];
    date = json['date'];
    time = json['time'];
    isCampaignActive = json['isCampaignActive'];
    campaignOrganizedBy = json['campaignOrganizedBy'] != null
        ? CampaignOrganizedBy.fromJson(json['campaignOrganizedBy'])
        : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['campaignName'] = campaignName;
    data['date'] = date;
    data['time'] = time;
    data['isCampaignActive'] = isCampaignActive;
    if (campaignOrganizedBy != null) {
      data['campaignOrganizedBy'] = campaignOrganizedBy!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class CampaignOrganizedBy {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? bloodGroup;
  String? role;
  String? imageUrl;
  bool? isAvailableForDonation;
  int? iV;

  CampaignOrganizedBy(
      {this.fullName,
      this.email,
      this.phoneNumber,
      this.bloodGroup,
      this.role,
      this.imageUrl,
      this.isAvailableForDonation,
      this.iV});

  CampaignOrganizedBy.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    bloodGroup = json['bloodGroup'];
    role = json['role'];
    imageUrl = json['imageUrl'];
    isAvailableForDonation = json['isAvailableForDonation'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fullName'] = fullName;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['bloodGroup'] = bloodGroup;
    data['role'] = role;
    data['imageUrl'] = imageUrl;
    data['isAvailableForDonation'] = isAvailableForDonation;
    data['__v'] = iV;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

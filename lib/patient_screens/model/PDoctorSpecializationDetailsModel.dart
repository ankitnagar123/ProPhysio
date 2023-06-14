class SpecializationDetailsModel {
  String? doctorId;
  String? description;
  String? catName;
  List<Subcategory>? subcategory;
  List<Details>? details;

  SpecializationDetailsModel(
      {this.doctorId,
        this.description,
        this.catName,
        this.subcategory,
        this.details});

  SpecializationDetailsModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'];
    description = json['description'];
    catName = json['cat_name'];
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(Subcategory.fromJson(v));
      });
    }
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_id'] = doctorId;
    data['description'] = description;
    data['cat_name'] = catName;
    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((v) => v.toJson()).toList();
    }
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  String? subcatId;
  String? subcatName;

  Subcategory({this.subcatId, this.subcatName});

  Subcategory.fromJson(Map<String, dynamic> json) {
    subcatId = json['subcat_id'];
    subcatName = json['subcat_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subcat_id'] = subcatId;
    data['subcat_name'] = subcatName;
    return data;
  }
}

class Details {
  String? name;
  String? price;

  Details({this.name, this.price});

  Details.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

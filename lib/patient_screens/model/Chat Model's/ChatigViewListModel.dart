class ChatingViewListModel {
  String? id;
  String? message;
  String? upstatus;
  String? sentat;
  String? date;
  List<Image>? image;

  ChatingViewListModel(
      {this.id,
        this.message,
        this.upstatus,
        this.sentat,
        this.date,
        this.image});

  ChatingViewListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    upstatus = json['upstatus'];
    sentat = json['sentat'];
    date = json['date'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['message'] = message;
    data['upstatus'] = upstatus;
    data['sentat'] = sentat;
    data['date'] = date;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Image {
  String? image;

  Image({this.image});

  Image.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}

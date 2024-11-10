// To parse this JSON data, do
//
//     final laptopDataModel = laptopDataModelFromJson(jsonString);

import 'dart:convert';

List<LaptopDataModel> laptopDataModelFromJson(String str) => List<LaptopDataModel>.from(json.decode(str).map((x) => LaptopDataModel.fromJson(x)));

String laptopDataModelToJson(List<LaptopDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LaptopDataModel {
    final dynamic id;
    final String modelName;
    final String company;
    final String operatingSystem;
    final String processorCompany;
    final dynamic processorModel;
    final dynamic graphicsCard;
    final dynamic display;
    final String memory;
    final String storage;
    final String link;
    final String price;
    final String imageUrl;
    final String name;

    LaptopDataModel({
        required this.id,
        required this.modelName,
        required this.company,
        required this.operatingSystem,
        required this.processorCompany,
        required this.processorModel,
        required this.graphicsCard,
        required this.display,
        required this.memory,
        required this.storage,
        required this.link,
        required this.price,
        required this.imageUrl,
        required this.name,
    });

    factory LaptopDataModel.fromJson(Map<String, dynamic> json) => LaptopDataModel(
        id: json["id"] ?? '', 
        modelName: json["modelName"] ?? '',
        company: json["company"] ?? '',
        operatingSystem: json["operatingSystem"] ?? '',
        processorCompany: json["processorCompany"] ?? '',
        processorModel: json["processorModel"] ?? '',
        graphicsCard: json["graphicsCard"] ?? '',
        display: json["display"] ?? '',
        memory: json["memory"] ?? '',
        storage: json["storage"] ?? '',
        link: json["link"] ?? '',
        price: json["price"] ?? '',
        imageUrl: json["imageUrl"] ?? '',
        name: json["name"] ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "modelName": modelName,
        "company": company,
        "operatingSystem": operatingSystem,
        "processorCompany": processorCompany,
        "processorModel": processorModel,
        "graphicsCard": graphicsCard,
        "display": display,
        "memory": memory,
        "storage": storage,
        "link": link,
        "price": price,
        "imageUrl": imageUrl,
        "name": name,
    };
}

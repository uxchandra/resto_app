import 'dart:convert';

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;
  Menu? menus;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
    this.menus,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    pictureId = json['pictureId'];
    city = json['city'];
    rating = json['rating'] is int
        ? (json['rating'] as int).toDouble()
        : json['rating'];
    menus = json['menus'] != null ? Menu.fromJson(json['menus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['pictureId'] = pictureId;
    data['city'] = city;
    data['rating'] = rating;
    if (menus != null) {
      data['menus'] = menus!.toJson();
    }
    return data;
  }
}

class Menu {
  Menu({
    required this.foods,
    required this.drinks,
  });

  List<Beverage> foods;
  List<Beverage> drinks;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods:
            List<Beverage>.from(json["foods"].map((x) => Beverage.fromJson(x))),
        drinks: List<Beverage>.from(
            json["drinks"].map((x) => Beverage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}


class Beverage {
  Beverage({
    required this.name,
  });

  String name;

  factory Beverage.fromJson(Map<String, dynamic> json) => Beverage(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }

  final List parsed = jsonDecode(json)['restaurants'];
  return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

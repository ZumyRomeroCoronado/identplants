class PlantsModele {
  PlantsModele({
    required this.data,
  });

  final List<Plant> data;

  factory PlantsModele.fromJson(Map<String, dynamic> json) => PlantsModele(
        data: List<Plant>.from(json["data"].map((x) => Plant.fromJson(x))),
      );
}

class Plant {
  Plant({
    required this.name,
    required this.description,
    required this.family,
    required this.benefit,
    required this.nombrecientifico,
  });

  final String name;
  final String description;
  final String family;
  final String benefit;
  final String nombrecientifico;

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        name: json["name"],
        description: json["description"],
        family: json["family"],
        benefit: json["benefit"],
        nombrecientifico: json["nombrecientifico"],
      );
}

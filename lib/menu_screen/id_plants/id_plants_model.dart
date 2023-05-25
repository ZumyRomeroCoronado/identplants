class ReportModele {
  ReportModele({
    required this.data,
  });

  final List<Report> data;

  factory ReportModele.fromJson(Map<String, dynamic> json) => ReportModele(
        data: List<Report>.from(json["data"].map((x) => Report.fromJson(x))),
      );
}

class Report {
  Report({
    required this.uid,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
    required this.foto,
    required this.plant,
    required this.usuario,
    required this.level,
  });

  final String uid;
  final String date;
  final String time;
  final String latitude;
  final String longitude;
  final String foto;
  final String plant;
  final String usuario;
  final double level;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        uid: json["uid"],
        date: json["date"],
        time: json["time"],
        latitude: json["latitude"].toString(),
        longitude:  json["longitude"].toString(),
        foto: json["plantImage"],
        plant: json["namePlant"],
        usuario: json["user"],
        level: json["level"],
      );
}

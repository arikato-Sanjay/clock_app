class AlarmInfo {
  int id;
  String description;
  DateTime alarmDateTime;
  bool isActive;
  int gradientIndex;

  AlarmInfo(
      {this.id,
      this.description,
      this.alarmDateTime,
      this.isActive,
      this.gradientIndex});

  factory AlarmInfo.fromMap(Map<String, dynamic> json) => AlarmInfo(
      id: json['id'],
      description: json['description'],
      alarmDateTime: DateTime.parse(json["alarmDateTime"]),
      isActive: json['isActive'],
      gradientIndex: json['gradientIndex']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "description": description,
        "alarmDateTime": alarmDateTime.toIso8601String(),
        "isActive": isActive,
        "gradientIndex": gradientIndex,
      };
}

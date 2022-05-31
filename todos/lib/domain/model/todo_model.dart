import 'package:objectbox/objectbox.dart';

@Entity()
class TodoModel {
  int id;

  @Property(type: PropertyType.date)
  DateTime createdDate;

  //@Property(type: PropertyType.char)
  String title;

  //@Property(type: PropertyType.char)
  String description;

  bool isFinished;

  TodoModel({
    this.id = 0,
    required this.title,
    required this.description,
    required this.createdDate,
    required this.isFinished,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["id"] = id;
    data["createdDate"] = createdDate;
    data["title"] = title;
    data["description"] = description;
    data["isFinished"] = isFinished;
    return data;
  }
}

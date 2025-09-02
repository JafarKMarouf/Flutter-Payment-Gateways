class Tip {
  int? id;
  String? title;
  String? description;

  Tip({this.id, this.title, this.description});

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }
}

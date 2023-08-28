class MetaDatum {
  int? id;
  String? key;
  String? value;

  MetaDatum({this.id, this.key, this.value});

  // factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
  //       id: json['id'] as int?,
  //       key: json['key'] as String?,
  //       value: json['value'] as String?,
  //     );

  factory MetaDatum.fromJson(Map<String, dynamic> json) {
    int? id = json['id'] as int?;
    String? key = json['key'] as String?;

    dynamic value = json['value'];
    String? valueString;

    if (value is String) {
      valueString = value;
    } else if (value is Map<String, dynamic>) {
      valueString = value.toString();
    } else {
      valueString = value.toString();
    }

    return MetaDatum(
      id: id,
      key: key,
      value: valueString,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'key': key,
        'value': value,
      };
}

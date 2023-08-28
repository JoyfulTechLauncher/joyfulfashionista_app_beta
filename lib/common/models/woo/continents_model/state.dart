class States {
  String? code;
  String? name;

  States({
    this.code,
    this.name,
  });

  @override
  String toString() {
    return 'States{code: $code, name: $name}';
  }
  factory States.fromJson(Map<String, dynamic> json) => States(
        code: "${json['code']}",
        name: "${json['name']}",
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}

import 'country.dart';
import 'links.dart';
import 'state.dart';

class ContinentsModel {
  String? code;
  String? name;
  List<States>? states;
  Links? links;

  //ContinentsModel({this.code, this.name, this.countries, this.links});
  @override
  String toString() {
    return 'ContinentsModel{code: $code, name: $name, states: $states, links: $links}';
  }
  ContinentsModel({this.code, this.name, this.states, this.links});

  factory ContinentsModel.fromJson(Map<String, dynamic> json) {
    return ContinentsModel(
      code: json['code'] as String?,
      name: json['name'] as String?,
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => States.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['_links'] == null
          ? null
          : Links.fromJson(json['_links'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'states': states?.map((e) => e.toJson()).toList(),
        '_links': links?.toJson(),
      };
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GuruProfileModel {
  final String name;
  final String dpUrl;
  final double rating;
  final String desc;
  GuruProfileModel({
    required this.name,
    required this.dpUrl,
    required this.rating,
    required this.desc,
  });
  

  GuruProfileModel copyWith({
    String? name,
    String? dpUrl,
    double? rating,
    String? desc,
  }) {
    return GuruProfileModel(
      name: name ?? this.name,
      dpUrl: dpUrl ?? this.dpUrl,
      rating: rating ?? this.rating,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dpUrl': dpUrl,
      'rating': rating,
      'desc': desc,
    };
  }

  factory GuruProfileModel.fromMap(Map<String, dynamic> map) {
    return GuruProfileModel(
      name: map['name'] as String,
      dpUrl: map['dpUrl'] as String,
      rating: map['rating'] as double,
      desc: map['desc'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GuruProfileModel.fromJson(String source) => GuruProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GuruProfileModel(name: $name, dpUrl: $dpUrl, rating: $rating, desc: $desc)';
  }

  @override
  bool operator ==(covariant GuruProfileModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.dpUrl == dpUrl &&
      other.rating == rating &&
      other.desc == desc;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      dpUrl.hashCode ^
      rating.hashCode ^
      desc.hashCode;
  }
}

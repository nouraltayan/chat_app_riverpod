// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<chatmodel> convertToChatModelList(List<Map<String, dynamic>> data) {
  return data.map((map) => chatmodel.fromMap(map)).toList();
}

class chatmodel {
  num id;
  String created_at;
  String message;
  bool is_me;
  chatmodel({
    required this.id,
    required this.created_at,
    required this.message,
    required this.is_me,
  });

  chatmodel copyWith({
    num? id,
    String? created_at,
    String? message,
    bool? is_me,
  }) {
    return chatmodel(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      message: message ?? this.message,
      is_me: is_me ?? this.is_me,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'message': message,
      'is_me': is_me,
    };
  }

  factory chatmodel.fromMap(Map<String, dynamic> map) {
    return chatmodel(
      id: map['id'] as num,
      created_at: map['created_at'] as String,
      message: map['message'] as String,
      is_me: map['is_me'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory chatmodel.fromJson(String source) =>
      chatmodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'chatmodel(id: $id, created_at: $created_at, message: $message, is_me: $is_me)';
  }

  @override
  bool operator ==(covariant chatmodel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.message == message &&
        other.is_me == is_me;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        message.hashCode ^
        is_me.hashCode;
  }
}

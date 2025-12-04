// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chore.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Chore {

 String get id; String get title; DateTime get createdAt; String? get description; DateTime? get completedAt; bool get isCompleted;
/// Create a copy of Chore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChoreCopyWith<Chore> get copyWith => _$ChoreCopyWithImpl<Chore>(this as Chore, _$identity);

  /// Serializes this Chore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chore&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,createdAt,description,completedAt,isCompleted);

@override
String toString() {
  return 'Chore(id: $id, title: $title, createdAt: $createdAt, description: $description, completedAt: $completedAt, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $ChoreCopyWith<$Res>  {
  factory $ChoreCopyWith(Chore value, $Res Function(Chore) _then) = _$ChoreCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime createdAt, String? description, DateTime? completedAt, bool isCompleted
});




}
/// @nodoc
class _$ChoreCopyWithImpl<$Res>
    implements $ChoreCopyWith<$Res> {
  _$ChoreCopyWithImpl(this._self, this._then);

  final Chore _self;
  final $Res Function(Chore) _then;

/// Create a copy of Chore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? createdAt = null,Object? description = freezed,Object? completedAt = freezed,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Chore].
extension ChorePatterns on Chore {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Chore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Chore() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Chore value)  $default,){
final _that = this;
switch (_that) {
case _Chore():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Chore value)?  $default,){
final _that = this;
switch (_that) {
case _Chore() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime createdAt,  String? description,  DateTime? completedAt,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Chore() when $default != null:
return $default(_that.id,_that.title,_that.createdAt,_that.description,_that.completedAt,_that.isCompleted);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime createdAt,  String? description,  DateTime? completedAt,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _Chore():
return $default(_that.id,_that.title,_that.createdAt,_that.description,_that.completedAt,_that.isCompleted);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime createdAt,  String? description,  DateTime? completedAt,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _Chore() when $default != null:
return $default(_that.id,_that.title,_that.createdAt,_that.description,_that.completedAt,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Chore implements Chore {
   _Chore({required this.id, required this.title, required this.createdAt, this.description, this.completedAt, this.isCompleted = false});
  factory _Chore.fromJson(Map<String, dynamic> json) => _$ChoreFromJson(json);

@override final  String id;
@override final  String title;
@override final  DateTime createdAt;
@override final  String? description;
@override final  DateTime? completedAt;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of Chore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChoreCopyWith<_Chore> get copyWith => __$ChoreCopyWithImpl<_Chore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chore&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.description, description) || other.description == description)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,createdAt,description,completedAt,isCompleted);

@override
String toString() {
  return 'Chore(id: $id, title: $title, createdAt: $createdAt, description: $description, completedAt: $completedAt, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$ChoreCopyWith<$Res> implements $ChoreCopyWith<$Res> {
  factory _$ChoreCopyWith(_Chore value, $Res Function(_Chore) _then) = __$ChoreCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime createdAt, String? description, DateTime? completedAt, bool isCompleted
});




}
/// @nodoc
class __$ChoreCopyWithImpl<$Res>
    implements _$ChoreCopyWith<$Res> {
  __$ChoreCopyWithImpl(this._self, this._then);

  final _Chore _self;
  final $Res Function(_Chore) _then;

/// Create a copy of Chore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? createdAt = null,Object? description = freezed,Object? completedAt = freezed,Object? isCompleted = null,}) {
  return _then(_Chore(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

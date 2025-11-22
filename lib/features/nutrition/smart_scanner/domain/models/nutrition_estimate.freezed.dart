// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NutritionEstimate {

 double get calories; double get protein; double get carbs; double get fat;/// Confidence between 0.0 and 1.0
 double get confidence;
/// Create a copy of NutritionEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NutritionEstimateCopyWith<NutritionEstimate> get copyWith => _$NutritionEstimateCopyWithImpl<NutritionEstimate>(this as NutritionEstimate, _$identity);

  /// Serializes this NutritionEstimate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NutritionEstimate&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.protein, protein) || other.protein == protein)&&(identical(other.carbs, carbs) || other.carbs == carbs)&&(identical(other.fat, fat) || other.fat == fat)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,calories,protein,carbs,fat,confidence);

@override
String toString() {
  return 'NutritionEstimate(calories: $calories, protein: $protein, carbs: $carbs, fat: $fat, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class $NutritionEstimateCopyWith<$Res>  {
  factory $NutritionEstimateCopyWith(NutritionEstimate value, $Res Function(NutritionEstimate) _then) = _$NutritionEstimateCopyWithImpl;
@useResult
$Res call({
 double calories, double protein, double carbs, double fat, double confidence
});




}
/// @nodoc
class _$NutritionEstimateCopyWithImpl<$Res>
    implements $NutritionEstimateCopyWith<$Res> {
  _$NutritionEstimateCopyWithImpl(this._self, this._then);

  final NutritionEstimate _self;
  final $Res Function(NutritionEstimate) _then;

/// Create a copy of NutritionEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? calories = null,Object? protein = null,Object? carbs = null,Object? fat = null,Object? confidence = null,}) {
  return _then(_self.copyWith(
calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as double,protein: null == protein ? _self.protein : protein // ignore: cast_nullable_to_non_nullable
as double,carbs: null == carbs ? _self.carbs : carbs // ignore: cast_nullable_to_non_nullable
as double,fat: null == fat ? _self.fat : fat // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [NutritionEstimate].
extension NutritionEstimatePatterns on NutritionEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NutritionEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NutritionEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NutritionEstimate value)  $default,){
final _that = this;
switch (_that) {
case _NutritionEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NutritionEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _NutritionEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double calories,  double protein,  double carbs,  double fat,  double confidence)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NutritionEstimate() when $default != null:
return $default(_that.calories,_that.protein,_that.carbs,_that.fat,_that.confidence);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double calories,  double protein,  double carbs,  double fat,  double confidence)  $default,) {final _that = this;
switch (_that) {
case _NutritionEstimate():
return $default(_that.calories,_that.protein,_that.carbs,_that.fat,_that.confidence);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double calories,  double protein,  double carbs,  double fat,  double confidence)?  $default,) {final _that = this;
switch (_that) {
case _NutritionEstimate() when $default != null:
return $default(_that.calories,_that.protein,_that.carbs,_that.fat,_that.confidence);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NutritionEstimate implements NutritionEstimate {
  const _NutritionEstimate({required this.calories, required this.protein, required this.carbs, required this.fat, required this.confidence});
  factory _NutritionEstimate.fromJson(Map<String, dynamic> json) => _$NutritionEstimateFromJson(json);

@override final  double calories;
@override final  double protein;
@override final  double carbs;
@override final  double fat;
/// Confidence between 0.0 and 1.0
@override final  double confidence;

/// Create a copy of NutritionEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NutritionEstimateCopyWith<_NutritionEstimate> get copyWith => __$NutritionEstimateCopyWithImpl<_NutritionEstimate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NutritionEstimateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NutritionEstimate&&(identical(other.calories, calories) || other.calories == calories)&&(identical(other.protein, protein) || other.protein == protein)&&(identical(other.carbs, carbs) || other.carbs == carbs)&&(identical(other.fat, fat) || other.fat == fat)&&(identical(other.confidence, confidence) || other.confidence == confidence));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,calories,protein,carbs,fat,confidence);

@override
String toString() {
  return 'NutritionEstimate(calories: $calories, protein: $protein, carbs: $carbs, fat: $fat, confidence: $confidence)';
}


}

/// @nodoc
abstract mixin class _$NutritionEstimateCopyWith<$Res> implements $NutritionEstimateCopyWith<$Res> {
  factory _$NutritionEstimateCopyWith(_NutritionEstimate value, $Res Function(_NutritionEstimate) _then) = __$NutritionEstimateCopyWithImpl;
@override @useResult
$Res call({
 double calories, double protein, double carbs, double fat, double confidence
});




}
/// @nodoc
class __$NutritionEstimateCopyWithImpl<$Res>
    implements _$NutritionEstimateCopyWith<$Res> {
  __$NutritionEstimateCopyWithImpl(this._self, this._then);

  final _NutritionEstimate _self;
  final $Res Function(_NutritionEstimate) _then;

/// Create a copy of NutritionEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? calories = null,Object? protein = null,Object? carbs = null,Object? fat = null,Object? confidence = null,}) {
  return _then(_NutritionEstimate(
calories: null == calories ? _self.calories : calories // ignore: cast_nullable_to_non_nullable
as double,protein: null == protein ? _self.protein : protein // ignore: cast_nullable_to_non_nullable
as double,carbs: null == carbs ? _self.carbs : carbs // ignore: cast_nullable_to_non_nullable
as double,fat: null == fat ? _self.fat : fat // ignore: cast_nullable_to_non_nullable
as double,confidence: null == confidence ? _self.confidence : confidence // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

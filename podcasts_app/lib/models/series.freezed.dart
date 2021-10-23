// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'series.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SeriesTearOff {
  const _$SeriesTearOff();

  _Series call(
      {String image = '',
      String description = '',
      String name = '',
      String channel = '',
      List<Episode> episodeList = const []}) {
    return _Series(
      image: image,
      description: description,
      name: name,
      channel: channel,
      episodeList: episodeList,
    );
  }
}

/// @nodoc
const $Series = _$SeriesTearOff();

/// @nodoc
mixin _$Series {
  String get image => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get channel => throw _privateConstructorUsedError;
  List<Episode> get episodeList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeriesCopyWith<Series> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesCopyWith<$Res> {
  factory $SeriesCopyWith(Series value, $Res Function(Series) then) =
      _$SeriesCopyWithImpl<$Res>;
  $Res call(
      {String image,
      String description,
      String name,
      String channel,
      List<Episode> episodeList});
}

/// @nodoc
class _$SeriesCopyWithImpl<$Res> implements $SeriesCopyWith<$Res> {
  _$SeriesCopyWithImpl(this._value, this._then);

  final Series _value;
  // ignore: unused_field
  final $Res Function(Series) _then;

  @override
  $Res call({
    Object? image = freezed,
    Object? description = freezed,
    Object? name = freezed,
    Object? channel = freezed,
    Object? episodeList = freezed,
  }) {
    return _then(_value.copyWith(
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      channel: channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      episodeList: episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
    ));
  }
}

/// @nodoc
abstract class _$SeriesCopyWith<$Res> implements $SeriesCopyWith<$Res> {
  factory _$SeriesCopyWith(_Series value, $Res Function(_Series) then) =
      __$SeriesCopyWithImpl<$Res>;
  @override
  $Res call(
      {String image,
      String description,
      String name,
      String channel,
      List<Episode> episodeList});
}

/// @nodoc
class __$SeriesCopyWithImpl<$Res> extends _$SeriesCopyWithImpl<$Res>
    implements _$SeriesCopyWith<$Res> {
  __$SeriesCopyWithImpl(_Series _value, $Res Function(_Series) _then)
      : super(_value, (v) => _then(v as _Series));

  @override
  _Series get _value => super._value as _Series;

  @override
  $Res call({
    Object? image = freezed,
    Object? description = freezed,
    Object? name = freezed,
    Object? channel = freezed,
    Object? episodeList = freezed,
  }) {
    return _then(_Series(
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      channel: channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as String,
      episodeList: episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
    ));
  }
}

/// @nodoc

class _$_Series implements _Series {
  const _$_Series(
      {this.image = '',
      this.description = '',
      this.name = '',
      this.channel = '',
      this.episodeList = const []});

  @JsonKey(defaultValue: '')
  @override
  final String image;
  @JsonKey(defaultValue: '')
  @override
  final String description;
  @JsonKey(defaultValue: '')
  @override
  final String name;
  @JsonKey(defaultValue: '')
  @override
  final String channel;
  @JsonKey(defaultValue: const [])
  @override
  final List<Episode> episodeList;

  @override
  String toString() {
    return 'Series(image: $image, description: $description, name: $name, channel: $channel, episodeList: $episodeList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Series &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.channel, channel) ||
                const DeepCollectionEquality()
                    .equals(other.channel, channel)) &&
            (identical(other.episodeList, episodeList) ||
                const DeepCollectionEquality()
                    .equals(other.episodeList, episodeList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(channel) ^
      const DeepCollectionEquality().hash(episodeList);

  @JsonKey(ignore: true)
  @override
  _$SeriesCopyWith<_Series> get copyWith =>
      __$SeriesCopyWithImpl<_Series>(this, _$identity);
}

abstract class _Series implements Series {
  const factory _Series(
      {String image,
      String description,
      String name,
      String channel,
      List<Episode> episodeList}) = _$_Series;

  @override
  String get image => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get channel => throw _privateConstructorUsedError;
  @override
  List<Episode> get episodeList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SeriesCopyWith<_Series> get copyWith => throw _privateConstructorUsedError;
}

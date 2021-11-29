// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChannelTearOff {
  const _$ChannelTearOff();

  _Channel call(
      {String name = '',
      String image = '',
      String id = '',
      String description = '',
      List<Series> seriesList = const []}) {
    return _Channel(
      name: name,
      image: image,
      id: id,
      description: description,
      seriesList: seriesList,
    );
  }
}

/// @nodoc
const $Channel = _$ChannelTearOff();

/// @nodoc
mixin _$Channel {
  String get name => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<Series> get seriesList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChannelCopyWith<Channel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelCopyWith<$Res> {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) then) =
      _$ChannelCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String image,
      String id,
      String description,
      List<Series> seriesList});
}

/// @nodoc
class _$ChannelCopyWithImpl<$Res> implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._value, this._then);

  final Channel _value;
  // ignore: unused_field
  final $Res Function(Channel) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? image = freezed,
    Object? id = freezed,
    Object? description = freezed,
    Object? seriesList = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      seriesList: seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
    ));
  }
}

/// @nodoc
abstract class _$ChannelCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$ChannelCopyWith(_Channel value, $Res Function(_Channel) then) =
      __$ChannelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String image,
      String id,
      String description,
      List<Series> seriesList});
}

/// @nodoc
class __$ChannelCopyWithImpl<$Res> extends _$ChannelCopyWithImpl<$Res>
    implements _$ChannelCopyWith<$Res> {
  __$ChannelCopyWithImpl(_Channel _value, $Res Function(_Channel) _then)
      : super(_value, (v) => _then(v as _Channel));

  @override
  _Channel get _value => super._value as _Channel;

  @override
  $Res call({
    Object? name = freezed,
    Object? image = freezed,
    Object? id = freezed,
    Object? description = freezed,
    Object? seriesList = freezed,
  }) {
    return _then(_Channel(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      seriesList: seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
    ));
  }
}

/// @nodoc

class _$_Channel extends _Channel {
  const _$_Channel(
      {this.name = '',
      this.image = '',
      this.id = '',
      this.description = '',
      this.seriesList = const []})
      : super._();

  @JsonKey(defaultValue: '')
  @override
  final String name;
  @JsonKey(defaultValue: '')
  @override
  final String image;
  @JsonKey(defaultValue: '')
  @override
  final String id;
  @JsonKey(defaultValue: '')
  @override
  final String description;
  @JsonKey(defaultValue: const [])
  @override
  final List<Series> seriesList;

  @override
  String toString() {
    return 'Channel(name: $name, image: $image, id: $id, description: $description, seriesList: $seriesList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Channel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other.seriesList, seriesList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, image, id, description,
      const DeepCollectionEquality().hash(seriesList));

  @JsonKey(ignore: true)
  @override
  _$ChannelCopyWith<_Channel> get copyWith =>
      __$ChannelCopyWithImpl<_Channel>(this, _$identity);
}

abstract class _Channel extends Channel {
  const factory _Channel(
      {String name,
      String image,
      String id,
      String description,
      List<Series> seriesList}) = _$_Channel;
  const _Channel._() : super._();

  @override
  String get name;
  @override
  String get image;
  @override
  String get id;
  @override
  String get description;
  @override
  List<Series> get seriesList;
  @override
  @JsonKey(ignore: true)
  _$ChannelCopyWith<_Channel> get copyWith =>
      throw _privateConstructorUsedError;
}

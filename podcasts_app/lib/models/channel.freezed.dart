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
      {String channelName = '',
      String channelImage = '',
      String channelDescription = '',
      List<dynamic> channelSeriesList = const [],
      String channelOwner = ''}) {
    return _Channel(
      channelName: channelName,
      channelImage: channelImage,
      channelDescription: channelDescription,
      channelSeriesList: channelSeriesList,
      channelOwner: channelOwner,
    );
  }
}

/// @nodoc
const $Channel = _$ChannelTearOff();

/// @nodoc
mixin _$Channel {
  String get channelName => throw _privateConstructorUsedError;
  String get channelImage => throw _privateConstructorUsedError;
  String get channelDescription => throw _privateConstructorUsedError;
  List<dynamic> get channelSeriesList => throw _privateConstructorUsedError;
  String get channelOwner => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChannelCopyWith<Channel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelCopyWith<$Res> {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) then) =
      _$ChannelCopyWithImpl<$Res>;
  $Res call(
      {String channelName,
      String channelImage,
      String channelDescription,
      List<dynamic> channelSeriesList,
      String channelOwner});
}

/// @nodoc
class _$ChannelCopyWithImpl<$Res> implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._value, this._then);

  final Channel _value;
  // ignore: unused_field
  final $Res Function(Channel) _then;

  @override
  $Res call({
    Object? channelName = freezed,
    Object? channelImage = freezed,
    Object? channelDescription = freezed,
    Object? channelSeriesList = freezed,
    Object? channelOwner = freezed,
  }) {
    return _then(_value.copyWith(
      channelName: channelName == freezed
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      channelImage: channelImage == freezed
          ? _value.channelImage
          : channelImage // ignore: cast_nullable_to_non_nullable
              as String,
      channelDescription: channelDescription == freezed
          ? _value.channelDescription
          : channelDescription // ignore: cast_nullable_to_non_nullable
              as String,
      channelSeriesList: channelSeriesList == freezed
          ? _value.channelSeriesList
          : channelSeriesList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      channelOwner: channelOwner == freezed
          ? _value.channelOwner
          : channelOwner // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ChannelCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$ChannelCopyWith(_Channel value, $Res Function(_Channel) then) =
      __$ChannelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String channelName,
      String channelImage,
      String channelDescription,
      List<dynamic> channelSeriesList,
      String channelOwner});
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
    Object? channelName = freezed,
    Object? channelImage = freezed,
    Object? channelDescription = freezed,
    Object? channelSeriesList = freezed,
    Object? channelOwner = freezed,
  }) {
    return _then(_Channel(
      channelName: channelName == freezed
          ? _value.channelName
          : channelName // ignore: cast_nullable_to_non_nullable
              as String,
      channelImage: channelImage == freezed
          ? _value.channelImage
          : channelImage // ignore: cast_nullable_to_non_nullable
              as String,
      channelDescription: channelDescription == freezed
          ? _value.channelDescription
          : channelDescription // ignore: cast_nullable_to_non_nullable
              as String,
      channelSeriesList: channelSeriesList == freezed
          ? _value.channelSeriesList
          : channelSeriesList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      channelOwner: channelOwner == freezed
          ? _value.channelOwner
          : channelOwner // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_Channel extends _Channel {
  const _$_Channel(
      {this.channelName = '',
      this.channelImage = '',
      this.channelDescription = '',
      this.channelSeriesList = const [],
      this.channelOwner = ''})
      : super._();

  @JsonKey(defaultValue: '')
  @override
  final String channelName;
  @JsonKey(defaultValue: '')
  @override
  final String channelImage;
  @JsonKey(defaultValue: '')
  @override
  final String channelDescription;
  @JsonKey(defaultValue: const [])
  @override
  final List<dynamic> channelSeriesList;
  @JsonKey(defaultValue: '')
  @override
  final String channelOwner;

  @override
  String toString() {
    return 'Channel(channelName: $channelName, channelImage: $channelImage, channelDescription: $channelDescription, channelSeriesList: $channelSeriesList, channelOwner: $channelOwner)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Channel &&
            (identical(other.channelName, channelName) ||
                const DeepCollectionEquality()
                    .equals(other.channelName, channelName)) &&
            (identical(other.channelImage, channelImage) ||
                const DeepCollectionEquality()
                    .equals(other.channelImage, channelImage)) &&
            (identical(other.channelDescription, channelDescription) ||
                const DeepCollectionEquality()
                    .equals(other.channelDescription, channelDescription)) &&
            (identical(other.channelSeriesList, channelSeriesList) ||
                const DeepCollectionEquality()
                    .equals(other.channelSeriesList, channelSeriesList)) &&
            (identical(other.channelOwner, channelOwner) ||
                const DeepCollectionEquality()
                    .equals(other.channelOwner, channelOwner)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(channelName) ^
      const DeepCollectionEquality().hash(channelImage) ^
      const DeepCollectionEquality().hash(channelDescription) ^
      const DeepCollectionEquality().hash(channelSeriesList) ^
      const DeepCollectionEquality().hash(channelOwner);

  @JsonKey(ignore: true)
  @override
  _$ChannelCopyWith<_Channel> get copyWith =>
      __$ChannelCopyWithImpl<_Channel>(this, _$identity);
}

abstract class _Channel extends Channel {
  const factory _Channel(
      {String channelName,
      String channelImage,
      String channelDescription,
      List<dynamic> channelSeriesList,
      String channelOwner}) = _$_Channel;
  const _Channel._() : super._();

  @override
  String get channelName => throw _privateConstructorUsedError;
  @override
  String get channelImage => throw _privateConstructorUsedError;
  @override
  String get channelDescription => throw _privateConstructorUsedError;
  @override
  List<dynamic> get channelSeriesList => throw _privateConstructorUsedError;
  @override
  String get channelOwner => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChannelCopyWith<_Channel> get copyWith =>
      throw _privateConstructorUsedError;
}

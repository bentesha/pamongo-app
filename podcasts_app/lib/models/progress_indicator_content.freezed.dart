// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'progress_indicator_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProgressIndicatorContentTearOff {
  const _$ProgressIndicatorContentTearOff();

  _ProgressIndicatorContent call(
      {required List<dynamic> episodeList,
      int currentPosition = 0,
      IndicatorPlayerState playerState = inactiveState,
      SortStyles sortStyle = SortStyles.oldestFirst,
      AudioError? error,
      int currentIndex = 0}) {
    return _ProgressIndicatorContent(
      episodeList: episodeList,
      currentPosition: currentPosition,
      playerState: playerState,
      sortStyle: sortStyle,
      error: error,
      currentIndex: currentIndex,
    );
  }
}

/// @nodoc
const $ProgressIndicatorContent = _$ProgressIndicatorContentTearOff();

/// @nodoc
mixin _$ProgressIndicatorContent {
  List<dynamic> get episodeList => throw _privateConstructorUsedError;
  int get currentPosition => throw _privateConstructorUsedError;
  IndicatorPlayerState get playerState => throw _privateConstructorUsedError;
  SortStyles get sortStyle => throw _privateConstructorUsedError;
  AudioError? get error => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgressIndicatorContentCopyWith<ProgressIndicatorContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressIndicatorContentCopyWith<$Res> {
  factory $ProgressIndicatorContentCopyWith(ProgressIndicatorContent value,
          $Res Function(ProgressIndicatorContent) then) =
      _$ProgressIndicatorContentCopyWithImpl<$Res>;
  $Res call(
      {List<dynamic> episodeList,
      int currentPosition,
      IndicatorPlayerState playerState,
      SortStyles sortStyle,
      AudioError? error,
      int currentIndex});
}

/// @nodoc
class _$ProgressIndicatorContentCopyWithImpl<$Res>
    implements $ProgressIndicatorContentCopyWith<$Res> {
  _$ProgressIndicatorContentCopyWithImpl(this._value, this._then);

  final ProgressIndicatorContent _value;
  // ignore: unused_field
  final $Res Function(ProgressIndicatorContent) _then;

  @override
  $Res call({
    Object? episodeList = freezed,
    Object? currentPosition = freezed,
    Object? playerState = freezed,
    Object? sortStyle = freezed,
    Object? error = freezed,
    Object? currentIndex = freezed,
  }) {
    return _then(_value.copyWith(
      episodeList: episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      currentPosition: currentPosition == freezed
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as int,
      playerState: playerState == freezed
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as IndicatorPlayerState,
      sortStyle: sortStyle == freezed
          ? _value.sortStyle
          : sortStyle // ignore: cast_nullable_to_non_nullable
              as SortStyles,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AudioError?,
      currentIndex: currentIndex == freezed
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ProgressIndicatorContentCopyWith<$Res>
    implements $ProgressIndicatorContentCopyWith<$Res> {
  factory _$ProgressIndicatorContentCopyWith(_ProgressIndicatorContent value,
          $Res Function(_ProgressIndicatorContent) then) =
      __$ProgressIndicatorContentCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<dynamic> episodeList,
      int currentPosition,
      IndicatorPlayerState playerState,
      SortStyles sortStyle,
      AudioError? error,
      int currentIndex});
}

/// @nodoc
class __$ProgressIndicatorContentCopyWithImpl<$Res>
    extends _$ProgressIndicatorContentCopyWithImpl<$Res>
    implements _$ProgressIndicatorContentCopyWith<$Res> {
  __$ProgressIndicatorContentCopyWithImpl(_ProgressIndicatorContent _value,
      $Res Function(_ProgressIndicatorContent) _then)
      : super(_value, (v) => _then(v as _ProgressIndicatorContent));

  @override
  _ProgressIndicatorContent get _value =>
      super._value as _ProgressIndicatorContent;

  @override
  $Res call({
    Object? episodeList = freezed,
    Object? currentPosition = freezed,
    Object? playerState = freezed,
    Object? sortStyle = freezed,
    Object? error = freezed,
    Object? currentIndex = freezed,
  }) {
    return _then(_ProgressIndicatorContent(
      episodeList: episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      currentPosition: currentPosition == freezed
          ? _value.currentPosition
          : currentPosition // ignore: cast_nullable_to_non_nullable
              as int,
      playerState: playerState == freezed
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as IndicatorPlayerState,
      sortStyle: sortStyle == freezed
          ? _value.sortStyle
          : sortStyle // ignore: cast_nullable_to_non_nullable
              as SortStyles,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AudioError?,
      currentIndex: currentIndex == freezed
          ? _value.currentIndex
          : currentIndex // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ProgressIndicatorContent implements _ProgressIndicatorContent {
  const _$_ProgressIndicatorContent(
      {required this.episodeList,
      this.currentPosition = 0,
      this.playerState = inactiveState,
      this.sortStyle = SortStyles.oldestFirst,
      this.error,
      this.currentIndex = 0});

  @override
  final List<dynamic> episodeList;
  @JsonKey(defaultValue: 0)
  @override
  final int currentPosition;
  @JsonKey(defaultValue: inactiveState)
  @override
  final IndicatorPlayerState playerState;
  @JsonKey(defaultValue: SortStyles.oldestFirst)
  @override
  final SortStyles sortStyle;
  @override
  final AudioError? error;
  @JsonKey(defaultValue: 0)
  @override
  final int currentIndex;

  @override
  String toString() {
    return 'ProgressIndicatorContent(episodeList: $episodeList, currentPosition: $currentPosition, playerState: $playerState, sortStyle: $sortStyle, error: $error, currentIndex: $currentIndex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ProgressIndicatorContent &&
            (identical(other.episodeList, episodeList) ||
                const DeepCollectionEquality()
                    .equals(other.episodeList, episodeList)) &&
            (identical(other.currentPosition, currentPosition) ||
                const DeepCollectionEquality()
                    .equals(other.currentPosition, currentPosition)) &&
            (identical(other.playerState, playerState) ||
                const DeepCollectionEquality()
                    .equals(other.playerState, playerState)) &&
            (identical(other.sortStyle, sortStyle) ||
                const DeepCollectionEquality()
                    .equals(other.sortStyle, sortStyle)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.currentIndex, currentIndex) ||
                const DeepCollectionEquality()
                    .equals(other.currentIndex, currentIndex)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(episodeList) ^
      const DeepCollectionEquality().hash(currentPosition) ^
      const DeepCollectionEquality().hash(playerState) ^
      const DeepCollectionEquality().hash(sortStyle) ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(currentIndex);

  @JsonKey(ignore: true)
  @override
  _$ProgressIndicatorContentCopyWith<_ProgressIndicatorContent> get copyWith =>
      __$ProgressIndicatorContentCopyWithImpl<_ProgressIndicatorContent>(
          this, _$identity);
}

abstract class _ProgressIndicatorContent implements ProgressIndicatorContent {
  const factory _ProgressIndicatorContent(
      {required List<dynamic> episodeList,
      int currentPosition,
      IndicatorPlayerState playerState,
      SortStyles sortStyle,
      AudioError? error,
      int currentIndex}) = _$_ProgressIndicatorContent;

  @override
  List<dynamic> get episodeList => throw _privateConstructorUsedError;
  @override
  int get currentPosition => throw _privateConstructorUsedError;
  @override
  IndicatorPlayerState get playerState => throw _privateConstructorUsedError;
  @override
  SortStyles get sortStyle => throw _privateConstructorUsedError;
  @override
  AudioError? get error => throw _privateConstructorUsedError;
  @override
  int get currentIndex => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProgressIndicatorContentCopyWith<_ProgressIndicatorContent> get copyWith =>
      throw _privateConstructorUsedError;
}

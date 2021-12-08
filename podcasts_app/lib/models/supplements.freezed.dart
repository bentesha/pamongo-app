// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'supplements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SupplementsTearOff {
  const _$SupplementsTearOff();

  _Supplements call(
      {String activeId = '',
      SortStyles sortStyle = SortStyles.oldestFirst,
      ApiError? apiError,
      required IndicatorPlayerState playerState}) {
    return _Supplements(
      activeId: activeId,
      sortStyle: sortStyle,
      apiError: apiError,
      playerState: playerState,
    );
  }
}

/// @nodoc
const $Supplements = _$SupplementsTearOff();

/// @nodoc
mixin _$Supplements {
  String get activeId => throw _privateConstructorUsedError;
  SortStyles get sortStyle => throw _privateConstructorUsedError;
  ApiError? get apiError => throw _privateConstructorUsedError;
  IndicatorPlayerState get playerState => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SupplementsCopyWith<Supplements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupplementsCopyWith<$Res> {
  factory $SupplementsCopyWith(
          Supplements value, $Res Function(Supplements) then) =
      _$SupplementsCopyWithImpl<$Res>;
  $Res call(
      {String activeId,
      SortStyles sortStyle,
      ApiError? apiError,
      IndicatorPlayerState playerState});
}

/// @nodoc
class _$SupplementsCopyWithImpl<$Res> implements $SupplementsCopyWith<$Res> {
  _$SupplementsCopyWithImpl(this._value, this._then);

  final Supplements _value;
  // ignore: unused_field
  final $Res Function(Supplements) _then;

  @override
  $Res call({
    Object? activeId = freezed,
    Object? sortStyle = freezed,
    Object? apiError = freezed,
    Object? playerState = freezed,
  }) {
    return _then(_value.copyWith(
      activeId: activeId == freezed
          ? _value.activeId
          : activeId // ignore: cast_nullable_to_non_nullable
              as String,
      sortStyle: sortStyle == freezed
          ? _value.sortStyle
          : sortStyle // ignore: cast_nullable_to_non_nullable
              as SortStyles,
      apiError: apiError == freezed
          ? _value.apiError
          : apiError // ignore: cast_nullable_to_non_nullable
              as ApiError?,
      playerState: playerState == freezed
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as IndicatorPlayerState,
    ));
  }
}

/// @nodoc
abstract class _$SupplementsCopyWith<$Res>
    implements $SupplementsCopyWith<$Res> {
  factory _$SupplementsCopyWith(
          _Supplements value, $Res Function(_Supplements) then) =
      __$SupplementsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String activeId,
      SortStyles sortStyle,
      ApiError? apiError,
      IndicatorPlayerState playerState});
}

/// @nodoc
class __$SupplementsCopyWithImpl<$Res> extends _$SupplementsCopyWithImpl<$Res>
    implements _$SupplementsCopyWith<$Res> {
  __$SupplementsCopyWithImpl(
      _Supplements _value, $Res Function(_Supplements) _then)
      : super(_value, (v) => _then(v as _Supplements));

  @override
  _Supplements get _value => super._value as _Supplements;

  @override
  $Res call({
    Object? activeId = freezed,
    Object? sortStyle = freezed,
    Object? apiError = freezed,
    Object? playerState = freezed,
  }) {
    return _then(_Supplements(
      activeId: activeId == freezed
          ? _value.activeId
          : activeId // ignore: cast_nullable_to_non_nullable
              as String,
      sortStyle: sortStyle == freezed
          ? _value.sortStyle
          : sortStyle // ignore: cast_nullable_to_non_nullable
              as SortStyles,
      apiError: apiError == freezed
          ? _value.apiError
          : apiError // ignore: cast_nullable_to_non_nullable
              as ApiError?,
      playerState: playerState == freezed
          ? _value.playerState
          : playerState // ignore: cast_nullable_to_non_nullable
              as IndicatorPlayerState,
    ));
  }
}

/// @nodoc

class _$_Supplements implements _Supplements {
  const _$_Supplements(
      {this.activeId = '',
      this.sortStyle = SortStyles.oldestFirst,
      this.apiError,
      required this.playerState});

  @JsonKey(defaultValue: '')
  @override
  final String activeId;
  @JsonKey(defaultValue: SortStyles.oldestFirst)
  @override
  final SortStyles sortStyle;
  @override
  final ApiError? apiError;
  @override
  final IndicatorPlayerState playerState;

  @override
  String toString() {
    return 'Supplements(activeId: $activeId, sortStyle: $sortStyle, apiError: $apiError, playerState: $playerState)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Supplements &&
            (identical(other.activeId, activeId) ||
                other.activeId == activeId) &&
            (identical(other.sortStyle, sortStyle) ||
                other.sortStyle == sortStyle) &&
            (identical(other.apiError, apiError) ||
                other.apiError == apiError) &&
            (identical(other.playerState, playerState) ||
                other.playerState == playerState));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, activeId, sortStyle, apiError, playerState);

  @JsonKey(ignore: true)
  @override
  _$SupplementsCopyWith<_Supplements> get copyWith =>
      __$SupplementsCopyWithImpl<_Supplements>(this, _$identity);
}

abstract class _Supplements implements Supplements {
  const factory _Supplements(
      {String activeId,
      SortStyles sortStyle,
      ApiError? apiError,
      required IndicatorPlayerState playerState}) = _$_Supplements;

  @override
  String get activeId;
  @override
  SortStyles get sortStyle;
  @override
  ApiError? get apiError;
  @override
  IndicatorPlayerState get playerState;
  @override
  @JsonKey(ignore: true)
  _$SupplementsCopyWith<_Supplements> get copyWith =>
      throw _privateConstructorUsedError;
}

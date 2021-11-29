// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'series_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SeriesPageStateTearOff {
  const _$SeriesPageStateTearOff();

  _Loading loading(Series series, Supplements supplements) {
    return _Loading(
      series,
      supplements,
    );
  }

  _Content content(Series series, Supplements supplements) {
    return _Content(
      series,
      supplements,
    );
  }

  _Failed failed(Series series, Supplements supplements) {
    return _Failed(
      series,
      supplements,
    );
  }
}

/// @nodoc
const $SeriesPageState = _$SeriesPageStateTearOff();

/// @nodoc
mixin _$SeriesPageState {
  Series get series => throw _privateConstructorUsedError;
  Supplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Series series, Supplements supplements) loading,
    required TResult Function(Series series, Supplements supplements) content,
    required TResult Function(Series series, Supplements supplements) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Series series, Supplements supplements)? loading,
    TResult Function(Series series, Supplements supplements)? content,
    TResult Function(Series series, Supplements supplements)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Series series, Supplements supplements)? loading,
    TResult Function(Series series, Supplements supplements)? content,
    TResult Function(Series series, Supplements supplements)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SeriesPageStateCopyWith<SeriesPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeriesPageStateCopyWith<$Res> {
  factory $SeriesPageStateCopyWith(
          SeriesPageState value, $Res Function(SeriesPageState) then) =
      _$SeriesPageStateCopyWithImpl<$Res>;
  $Res call({Series series, Supplements supplements});

  $SeriesCopyWith<$Res> get series;
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$SeriesPageStateCopyWithImpl<$Res>
    implements $SeriesPageStateCopyWith<$Res> {
  _$SeriesPageStateCopyWithImpl(this._value, this._then);

  final SeriesPageState _value;
  // ignore: unused_field
  final $Res Function(SeriesPageState) _then;

  @override
  $Res call({
    Object? series = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      series: series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as Series,
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }

  @override
  $SeriesCopyWith<$Res> get series {
    return $SeriesCopyWith<$Res>(_value.series, (value) {
      return _then(_value.copyWith(series: value));
    });
  }

  @override
  $SupplementsCopyWith<$Res> get supplements {
    return $SupplementsCopyWith<$Res>(_value.supplements, (value) {
      return _then(_value.copyWith(supplements: value));
    });
  }
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res>
    implements $SeriesPageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({Series series, Supplements supplements});

  @override
  $SeriesCopyWith<$Res> get series;
  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$SeriesPageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? series = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Loading(
      series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as Series,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.series, this.supplements);

  @override
  final Series series;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'SeriesPageState.loading(series: $series, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(runtimeType, series, supplements);

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Series series, Supplements supplements) loading,
    required TResult Function(Series series, Supplements supplements) content,
    required TResult Function(Series series, Supplements supplements) failed,
  }) {
    return loading(series, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Series series, Supplements supplements)? loading,
    TResult Function(Series series, Supplements supplements)? content,
    TResult Function(Series series, Supplements supplements)? failed,
  }) {
    return loading?.call(series, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Series series, Supplements supplements)? loading,
    TResult Function(Series series, Supplements supplements)? content,
    TResult Function(Series series, Supplements supplements)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(series, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SeriesPageState {
  const factory _Loading(Series series, Supplements supplements) = _$_Loading;

  @override
  Series get series;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $SeriesPageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({Series series, Supplements supplements});

  @override
  $SeriesCopyWith<$Res> get series;
  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$SeriesPageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? series = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as Series,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.series, this.supplements);

  @override
  final Series series;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'SeriesPageState.content(series: $series, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(runtimeType, series, supplements);

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Series series, Supplements supplements) loading,
    required TResult Function(Series series, Supplements supplements) content,
    required TResult Function(Series series, Supplements supplements) failed,
  }) {
    return content(series, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Series series, Supplements supplements)? loading,
    TResult Function(Series series, Supplements supplements)? content,
    TResult Function(Series series, Supplements supplements)? failed,
  }) {
    return content?.call(series, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Series series, Supplements supplements)? loading,
    TResult Function(Series series, Supplements supplements)? content,
    TResult Function(Series series, Supplements supplements)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(series, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements SeriesPageState {
  const factory _Content(Series series, Supplements supplements) = _$_Content;

  @override
  Series get series;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res>
    implements $SeriesPageStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call({Series series, Supplements supplements});

  @override
  $SeriesCopyWith<$Res> get series;
  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$FailedCopyWithImpl<$Res> extends _$SeriesPageStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? series = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Failed(
      series == freezed
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as Series,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.series, this.supplements);

  @override
  final Series series;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'SeriesPageState.failed(series: $series, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(runtimeType, series, supplements);

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Series series, Supplements supplements) loading,
    required TResult Function(Series series, Supplements supplements) content,
    required TResult Function(Series series, Supplements supplements) failed,
  }) {
    return failed(series, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Series series, Supplements supplements)? loading,
    TResult Function(Series series, Supplements supplements)? content,
    TResult Function(Series series, Supplements supplements)? failed,
  }) {
    return failed?.call(series, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Series series, Supplements supplements)? loading,
    TResult Function(Series series, Supplements supplements)? content,
    TResult Function(Series series, Supplements supplements)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(series, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
    required TResult Function(_Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements SeriesPageState {
  const factory _Failed(Series series, Supplements supplements) = _$_Failed;

  @override
  Series get series;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}

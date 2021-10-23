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

  _Loading loading(List<Episode> episodeList, Supplements supplements) {
    return _Loading(
      episodeList,
      supplements,
    );
  }

  _Content content(List<Episode> episodeList, Supplements supplements) {
    return _Content(
      episodeList,
      supplements,
    );
  }

  _Failed failed(List<Episode> episodeList, Supplements supplements) {
    return _Failed(
      episodeList,
      supplements,
    );
  }
}

/// @nodoc
const $SeriesPageState = _$SeriesPageStateTearOff();

/// @nodoc
mixin _$SeriesPageState {
  List<Episode> get episodeList => throw _privateConstructorUsedError;
  Supplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        loading,
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        content,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        content,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        failed,
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
  $Res call({List<Episode> episodeList, Supplements supplements});

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
    Object? episodeList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      episodeList: episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
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
  $Res call({List<Episode> episodeList, Supplements supplements});

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
    Object? episodeList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Loading(
      episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.episodeList, this.supplements);

  @override
  final List<Episode> episodeList;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'SeriesPageState.loading(episodeList: $episodeList, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Loading &&
            (identical(other.episodeList, episodeList) ||
                const DeepCollectionEquality()
                    .equals(other.episodeList, episodeList)) &&
            (identical(other.supplements, supplements) ||
                const DeepCollectionEquality()
                    .equals(other.supplements, supplements)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(episodeList) ^
      const DeepCollectionEquality().hash(supplements);

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        loading,
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        failed,
  }) {
    return loading(episodeList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        content,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        failed,
  }) {
    return loading?.call(episodeList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        content,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(episodeList, supplements);
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
  const factory _Loading(List<Episode> episodeList, Supplements supplements) =
      _$_Loading;

  @override
  List<Episode> get episodeList => throw _privateConstructorUsedError;
  @override
  Supplements get supplements => throw _privateConstructorUsedError;
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
  $Res call({List<Episode> episodeList, Supplements supplements});

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
    Object? episodeList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.episodeList, this.supplements);

  @override
  final List<Episode> episodeList;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'SeriesPageState.content(episodeList: $episodeList, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Content &&
            (identical(other.episodeList, episodeList) ||
                const DeepCollectionEquality()
                    .equals(other.episodeList, episodeList)) &&
            (identical(other.supplements, supplements) ||
                const DeepCollectionEquality()
                    .equals(other.supplements, supplements)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(episodeList) ^
      const DeepCollectionEquality().hash(supplements);

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        loading,
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        failed,
  }) {
    return content(episodeList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        content,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        failed,
  }) {
    return content?.call(episodeList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        content,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(episodeList, supplements);
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
  const factory _Content(List<Episode> episodeList, Supplements supplements) =
      _$_Content;

  @override
  List<Episode> get episodeList => throw _privateConstructorUsedError;
  @override
  Supplements get supplements => throw _privateConstructorUsedError;
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
  $Res call({List<Episode> episodeList, Supplements supplements});

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
    Object? episodeList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Failed(
      episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.episodeList, this.supplements);

  @override
  final List<Episode> episodeList;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'SeriesPageState.failed(episodeList: $episodeList, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Failed &&
            (identical(other.episodeList, episodeList) ||
                const DeepCollectionEquality()
                    .equals(other.episodeList, episodeList)) &&
            (identical(other.supplements, supplements) ||
                const DeepCollectionEquality()
                    .equals(other.supplements, supplements)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(episodeList) ^
      const DeepCollectionEquality().hash(supplements);

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        loading,
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodeList, Supplements supplements)
        failed,
  }) {
    return failed(episodeList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        content,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        failed,
  }) {
    return failed?.call(episodeList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        content,
    TResult Function(List<Episode> episodeList, Supplements supplements)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(episodeList, supplements);
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
  const factory _Failed(List<Episode> episodeList, Supplements supplements) =
      _$_Failed;

  @override
  List<Episode> get episodeList => throw _privateConstructorUsedError;
  @override
  Supplements get supplements => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}

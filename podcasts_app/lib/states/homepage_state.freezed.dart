// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'homepage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$HomepageStateTearOff {
  const _$HomepageStateTearOff();

  _Loading loading(List<Episode> episodeList, List<Series> seriesList,
      Supplements supplements) {
    return _Loading(
      episodeList,
      seriesList,
      supplements,
    );
  }

  _Failed failed(List<Episode> episodeList, List<Series> seriesList,
      Supplements supplements) {
    return _Failed(
      episodeList,
      seriesList,
      supplements,
    );
  }

  _Content content(List<Episode> episodeList, List<Series> seriesList,
      Supplements supplements) {
    return _Content(
      episodeList,
      seriesList,
      supplements,
    );
  }
}

/// @nodoc
const $HomepageState = _$HomepageStateTearOff();

/// @nodoc
mixin _$HomepageState {
  List<Episode> get episodeList => throw _privateConstructorUsedError;
  List<Series> get seriesList => throw _privateConstructorUsedError;
  Supplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        loading,
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        failed,
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        content,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        failed,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        content,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        failed,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        content,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Content value) content,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Content value)? content,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Content value)? content,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomepageStateCopyWith<HomepageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomepageStateCopyWith<$Res> {
  factory $HomepageStateCopyWith(
          HomepageState value, $Res Function(HomepageState) then) =
      _$HomepageStateCopyWithImpl<$Res>;
  $Res call(
      {List<Episode> episodeList,
      List<Series> seriesList,
      Supplements supplements});

  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$HomepageStateCopyWithImpl<$Res>
    implements $HomepageStateCopyWith<$Res> {
  _$HomepageStateCopyWithImpl(this._value, this._then);

  final HomepageState _value;
  // ignore: unused_field
  final $Res Function(HomepageState) _then;

  @override
  $Res call({
    Object? episodeList = freezed,
    Object? seriesList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      episodeList: episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      seriesList: seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
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
abstract class _$LoadingCopyWith<$Res> implements $HomepageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Episode> episodeList,
      List<Series> seriesList,
      Supplements supplements});

  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$HomepageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? episodeList = freezed,
    Object? seriesList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Loading(
      episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.episodeList, this.seriesList, this.supplements);

  @override
  final List<Episode> episodeList;
  @override
  final List<Series> seriesList;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'HomepageState.loading(episodeList: $episodeList, seriesList: $seriesList, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            const DeepCollectionEquality()
                .equals(other.episodeList, episodeList) &&
            const DeepCollectionEquality()
                .equals(other.seriesList, seriesList) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(episodeList),
      const DeepCollectionEquality().hash(seriesList),
      supplements);

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        loading,
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        failed,
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        content,
  }) {
    return loading(episodeList, seriesList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        failed,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        content,
  }) {
    return loading?.call(episodeList, seriesList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        failed,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        content,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(episodeList, seriesList, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Content value) content,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Content value)? content,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Content value)? content,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements HomepageState {
  const factory _Loading(List<Episode> episodeList, List<Series> seriesList,
      Supplements supplements) = _$_Loading;

  @override
  List<Episode> get episodeList;
  @override
  List<Series> get seriesList;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res> implements $HomepageStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Episode> episodeList,
      List<Series> seriesList,
      Supplements supplements});

  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$FailedCopyWithImpl<$Res> extends _$HomepageStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? episodeList = freezed,
    Object? seriesList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Failed(
      episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.episodeList, this.seriesList, this.supplements);

  @override
  final List<Episode> episodeList;
  @override
  final List<Series> seriesList;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'HomepageState.failed(episodeList: $episodeList, seriesList: $seriesList, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            const DeepCollectionEquality()
                .equals(other.episodeList, episodeList) &&
            const DeepCollectionEquality()
                .equals(other.seriesList, seriesList) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(episodeList),
      const DeepCollectionEquality().hash(seriesList),
      supplements);

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        loading,
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        failed,
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        content,
  }) {
    return failed(episodeList, seriesList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        failed,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        content,
  }) {
    return failed?.call(episodeList, seriesList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        failed,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        content,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(episodeList, seriesList, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Content value) content,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Content value)? content,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Content value)? content,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements HomepageState {
  const factory _Failed(List<Episode> episodeList, List<Series> seriesList,
      Supplements supplements) = _$_Failed;

  @override
  List<Episode> get episodeList;
  @override
  List<Series> get seriesList;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res> implements $HomepageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Episode> episodeList,
      List<Series> seriesList,
      Supplements supplements});

  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$HomepageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? episodeList = freezed,
    Object? seriesList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      episodeList == freezed
          ? _value.episodeList
          : episodeList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.episodeList, this.seriesList, this.supplements);

  @override
  final List<Episode> episodeList;
  @override
  final List<Series> seriesList;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'HomepageState.content(episodeList: $episodeList, seriesList: $seriesList, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            const DeepCollectionEquality()
                .equals(other.episodeList, episodeList) &&
            const DeepCollectionEquality()
                .equals(other.seriesList, seriesList) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(episodeList),
      const DeepCollectionEquality().hash(seriesList),
      supplements);

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        loading,
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        failed,
    required TResult Function(List<Episode> episodeList,
            List<Series> seriesList, Supplements supplements)
        content,
  }) {
    return content(episodeList, seriesList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        failed,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        content,
  }) {
    return content?.call(episodeList, seriesList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        loading,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        failed,
    TResult Function(List<Episode> episodeList, List<Series> seriesList,
            Supplements supplements)?
        content,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(episodeList, seriesList, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
    required TResult Function(_Content value) content,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Content value)? content,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    TResult Function(_Content value)? content,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements HomepageState {
  const factory _Content(List<Episode> episodeList, List<Series> seriesList,
      Supplements supplements) = _$_Content;

  @override
  List<Episode> get episodeList;
  @override
  List<Series> get seriesList;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

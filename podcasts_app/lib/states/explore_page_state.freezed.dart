// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'explore_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ExplorePageStateTearOff {
  const _$ExplorePageStateTearOff();

  _Loading loading(List<Episode> episodesList, List<Series> seriesList,
      List<Channel> channelList, Supplements supplements) {
    return _Loading(
      episodesList,
      seriesList,
      channelList,
      supplements,
    );
  }

  _Content content(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      String searchKeyword,
      Supplements supplements) {
    return _Content(
      episodesList,
      seriesList,
      channelList,
      searchKeyword,
      supplements,
    );
  }

  _Failed failed(List<Episode> episodesList, List<Series> seriesList,
      List<Channel> channelList, Supplements supplements) {
    return _Failed(
      episodesList,
      seriesList,
      channelList,
      supplements,
    );
  }
}

/// @nodoc
const $ExplorePageState = _$ExplorePageStateTearOff();

/// @nodoc
mixin _$ExplorePageState {
  List<Episode> get episodesList => throw _privateConstructorUsedError;
  List<Series> get seriesList => throw _privateConstructorUsedError;
  List<Channel> get channelList => throw _privateConstructorUsedError;
  Supplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            Supplements supplements)
        loading,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            Supplements supplements)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        loading,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        loading,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
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
  $ExplorePageStateCopyWith<ExplorePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExplorePageStateCopyWith<$Res> {
  factory $ExplorePageStateCopyWith(
          ExplorePageState value, $Res Function(ExplorePageState) then) =
      _$ExplorePageStateCopyWithImpl<$Res>;
  $Res call(
      {List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      Supplements supplements});

  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$ExplorePageStateCopyWithImpl<$Res>
    implements $ExplorePageStateCopyWith<$Res> {
  _$ExplorePageStateCopyWithImpl(this._value, this._then);

  final ExplorePageState _value;
  // ignore: unused_field
  final $Res Function(ExplorePageState) _then;

  @override
  $Res call({
    Object? episodesList = freezed,
    Object? seriesList = freezed,
    Object? channelList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      episodesList: episodesList == freezed
          ? _value.episodesList
          : episodesList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      seriesList: seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
      channelList: channelList == freezed
          ? _value.channelList
          : channelList // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
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
    implements $ExplorePageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      Supplements supplements});

  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$ExplorePageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? episodesList = freezed,
    Object? seriesList = freezed,
    Object? channelList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Loading(
      episodesList == freezed
          ? _value.episodesList
          : episodesList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
      channelList == freezed
          ? _value.channelList
          : channelList // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(
      this.episodesList, this.seriesList, this.channelList, this.supplements);

  @override
  final List<Episode> episodesList;
  @override
  final List<Series> seriesList;
  @override
  final List<Channel> channelList;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'ExplorePageState.loading(episodesList: $episodesList, seriesList: $seriesList, channelList: $channelList, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            const DeepCollectionEquality()
                .equals(other.episodesList, episodesList) &&
            const DeepCollectionEquality()
                .equals(other.seriesList, seriesList) &&
            const DeepCollectionEquality()
                .equals(other.channelList, channelList) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(episodesList),
      const DeepCollectionEquality().hash(seriesList),
      const DeepCollectionEquality().hash(channelList),
      supplements);

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            Supplements supplements)
        loading,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            Supplements supplements)
        failed,
  }) {
    return loading(episodesList, seriesList, channelList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        loading,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        failed,
  }) {
    return loading?.call(episodesList, seriesList, channelList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        loading,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(episodesList, seriesList, channelList, supplements);
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

abstract class _Loading implements ExplorePageState {
  const factory _Loading(List<Episode> episodesList, List<Series> seriesList,
      List<Channel> channelList, Supplements supplements) = _$_Loading;

  @override
  List<Episode> get episodesList;
  @override
  List<Series> get seriesList;
  @override
  List<Channel> get channelList;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $ExplorePageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      String searchKeyword,
      Supplements supplements});

  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$ExplorePageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? episodesList = freezed,
    Object? seriesList = freezed,
    Object? channelList = freezed,
    Object? searchKeyword = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      episodesList == freezed
          ? _value.episodesList
          : episodesList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
      channelList == freezed
          ? _value.channelList
          : channelList // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
      searchKeyword == freezed
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.episodesList, this.seriesList, this.channelList,
      this.searchKeyword, this.supplements);

  @override
  final List<Episode> episodesList;
  @override
  final List<Series> seriesList;
  @override
  final List<Channel> channelList;
  @override
  final String searchKeyword;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'ExplorePageState.content(episodesList: $episodesList, seriesList: $seriesList, channelList: $channelList, searchKeyword: $searchKeyword, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            const DeepCollectionEquality()
                .equals(other.episodesList, episodesList) &&
            const DeepCollectionEquality()
                .equals(other.seriesList, seriesList) &&
            const DeepCollectionEquality()
                .equals(other.channelList, channelList) &&
            (identical(other.searchKeyword, searchKeyword) ||
                other.searchKeyword == searchKeyword) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(episodesList),
      const DeepCollectionEquality().hash(seriesList),
      const DeepCollectionEquality().hash(channelList),
      searchKeyword,
      supplements);

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            Supplements supplements)
        loading,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            Supplements supplements)
        failed,
  }) {
    return content(
        episodesList, seriesList, channelList, searchKeyword, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        loading,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        failed,
  }) {
    return content?.call(
        episodesList, seriesList, channelList, searchKeyword, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        loading,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(
          episodesList, seriesList, channelList, searchKeyword, supplements);
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

abstract class _Content implements ExplorePageState {
  const factory _Content(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      String searchKeyword,
      Supplements supplements) = _$_Content;

  @override
  List<Episode> get episodesList;
  @override
  List<Series> get seriesList;
  @override
  List<Channel> get channelList;
  String get searchKeyword;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res>
    implements $ExplorePageStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      Supplements supplements});

  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$FailedCopyWithImpl<$Res> extends _$ExplorePageStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? episodesList = freezed,
    Object? seriesList = freezed,
    Object? channelList = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Failed(
      episodesList == freezed
          ? _value.episodesList
          : episodesList // ignore: cast_nullable_to_non_nullable
              as List<Episode>,
      seriesList == freezed
          ? _value.seriesList
          : seriesList // ignore: cast_nullable_to_non_nullable
              as List<Series>,
      channelList == freezed
          ? _value.channelList
          : channelList // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(
      this.episodesList, this.seriesList, this.channelList, this.supplements);

  @override
  final List<Episode> episodesList;
  @override
  final List<Series> seriesList;
  @override
  final List<Channel> channelList;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'ExplorePageState.failed(episodesList: $episodesList, seriesList: $seriesList, channelList: $channelList, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            const DeepCollectionEquality()
                .equals(other.episodesList, episodesList) &&
            const DeepCollectionEquality()
                .equals(other.seriesList, seriesList) &&
            const DeepCollectionEquality()
                .equals(other.channelList, channelList) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(episodesList),
      const DeepCollectionEquality().hash(seriesList),
      const DeepCollectionEquality().hash(channelList),
      supplements);

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            Supplements supplements)
        loading,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            Supplements supplements)
        failed,
  }) {
    return failed(episodesList, seriesList, channelList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        loading,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        failed,
  }) {
    return failed?.call(episodesList, seriesList, channelList, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        loading,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(List<Episode> episodesList, List<Series> seriesList,
            List<Channel> channelList, Supplements supplements)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(episodesList, seriesList, channelList, supplements);
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

abstract class _Failed implements ExplorePageState {
  const factory _Failed(List<Episode> episodesList, List<Series> seriesList,
      List<Channel> channelList, Supplements supplements) = _$_Failed;

  @override
  List<Episode> get episodesList;
  @override
  List<Series> get seriesList;
  @override
  List<Channel> get channelList;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}

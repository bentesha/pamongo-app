// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SearchPageStateTearOff {
  const _$SearchPageStateTearOff();

  _Content content(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements) {
    return _Content(
      episodesList,
      seriesList,
      channelsList,
      searchKeyword,
      supplements,
    );
  }

  _Loading loading(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements) {
    return _Loading(
      episodesList,
      seriesList,
      channelsList,
      searchKeyword,
      supplements,
    );
  }
}

/// @nodoc
const $SearchPageState = _$SearchPageStateTearOff();

/// @nodoc
mixin _$SearchPageState {
  List<Episode> get episodesList => throw _privateConstructorUsedError;
  List<Series> get seriesList => throw _privateConstructorUsedError;
  List<Channel> get channelsList => throw _privateConstructorUsedError;
  String get searchKeyword => throw _privateConstructorUsedError;
  Supplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)
        loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Content value) content,
    required TResult Function(_Loading value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Content value)? content,
    TResult Function(_Loading value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Content value)? content,
    TResult Function(_Loading value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchPageStateCopyWith<SearchPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPageStateCopyWith<$Res> {
  factory $SearchPageStateCopyWith(
          SearchPageState value, $Res Function(SearchPageState) then) =
      _$SearchPageStateCopyWithImpl<$Res>;
  $Res call(
      {List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements});

  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$SearchPageStateCopyWithImpl<$Res>
    implements $SearchPageStateCopyWith<$Res> {
  _$SearchPageStateCopyWithImpl(this._value, this._then);

  final SearchPageState _value;
  // ignore: unused_field
  final $Res Function(SearchPageState) _then;

  @override
  $Res call({
    Object? episodesList = freezed,
    Object? seriesList = freezed,
    Object? channelsList = freezed,
    Object? searchKeyword = freezed,
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
      channelsList: channelsList == freezed
          ? _value.channelsList
          : channelsList // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
      searchKeyword: searchKeyword == freezed
          ? _value.searchKeyword
          : searchKeyword // ignore: cast_nullable_to_non_nullable
              as String,
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
abstract class _$ContentCopyWith<$Res>
    implements $SearchPageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements});

  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$SearchPageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? episodesList = freezed,
    Object? seriesList = freezed,
    Object? channelsList = freezed,
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
      channelsList == freezed
          ? _value.channelsList
          : channelsList // ignore: cast_nullable_to_non_nullable
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
  const _$_Content(this.episodesList, this.seriesList, this.channelsList,
      this.searchKeyword, this.supplements);

  @override
  final List<Episode> episodesList;
  @override
  final List<Series> seriesList;
  @override
  final List<Channel> channelsList;
  @override
  final String searchKeyword;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'SearchPageState.content(episodesList: $episodesList, seriesList: $seriesList, channelsList: $channelsList, searchKeyword: $searchKeyword, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Content &&
            (identical(other.episodesList, episodesList) ||
                const DeepCollectionEquality()
                    .equals(other.episodesList, episodesList)) &&
            (identical(other.seriesList, seriesList) ||
                const DeepCollectionEquality()
                    .equals(other.seriesList, seriesList)) &&
            (identical(other.channelsList, channelsList) ||
                const DeepCollectionEquality()
                    .equals(other.channelsList, channelsList)) &&
            (identical(other.searchKeyword, searchKeyword) ||
                const DeepCollectionEquality()
                    .equals(other.searchKeyword, searchKeyword)) &&
            (identical(other.supplements, supplements) ||
                const DeepCollectionEquality()
                    .equals(other.supplements, supplements)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(episodesList) ^
      const DeepCollectionEquality().hash(seriesList) ^
      const DeepCollectionEquality().hash(channelsList) ^
      const DeepCollectionEquality().hash(searchKeyword) ^
      const DeepCollectionEquality().hash(supplements);

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
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)
        loading,
  }) {
    return content(
        episodesList, seriesList, channelsList, searchKeyword, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        loading,
  }) {
    return content?.call(
        episodesList, seriesList, channelsList, searchKeyword, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        loading,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(
          episodesList, seriesList, channelsList, searchKeyword, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Content value) content,
    required TResult Function(_Loading value) loading,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Content value)? content,
    TResult Function(_Loading value)? loading,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Content value)? content,
    TResult Function(_Loading value)? loading,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements SearchPageState {
  const factory _Content(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements) = _$_Content;

  @override
  List<Episode> get episodesList => throw _privateConstructorUsedError;
  @override
  List<Series> get seriesList => throw _privateConstructorUsedError;
  @override
  List<Channel> get channelsList => throw _privateConstructorUsedError;
  @override
  String get searchKeyword => throw _privateConstructorUsedError;
  @override
  Supplements get supplements => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res>
    implements $SearchPageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements});

  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$SearchPageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? episodesList = freezed,
    Object? seriesList = freezed,
    Object? channelsList = freezed,
    Object? searchKeyword = freezed,
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
      channelsList == freezed
          ? _value.channelsList
          : channelsList // ignore: cast_nullable_to_non_nullable
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

class _$_Loading implements _Loading {
  const _$_Loading(this.episodesList, this.seriesList, this.channelsList,
      this.searchKeyword, this.supplements);

  @override
  final List<Episode> episodesList;
  @override
  final List<Series> seriesList;
  @override
  final List<Channel> channelsList;
  @override
  final String searchKeyword;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'SearchPageState.loading(episodesList: $episodesList, seriesList: $seriesList, channelsList: $channelsList, searchKeyword: $searchKeyword, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Loading &&
            (identical(other.episodesList, episodesList) ||
                const DeepCollectionEquality()
                    .equals(other.episodesList, episodesList)) &&
            (identical(other.seriesList, seriesList) ||
                const DeepCollectionEquality()
                    .equals(other.seriesList, seriesList)) &&
            (identical(other.channelsList, channelsList) ||
                const DeepCollectionEquality()
                    .equals(other.channelsList, channelsList)) &&
            (identical(other.searchKeyword, searchKeyword) ||
                const DeepCollectionEquality()
                    .equals(other.searchKeyword, searchKeyword)) &&
            (identical(other.supplements, supplements) ||
                const DeepCollectionEquality()
                    .equals(other.supplements, supplements)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(episodesList) ^
      const DeepCollectionEquality().hash(seriesList) ^
      const DeepCollectionEquality().hash(channelsList) ^
      const DeepCollectionEquality().hash(searchKeyword) ^
      const DeepCollectionEquality().hash(supplements);

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
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)
        content,
    required TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)
        loading,
  }) {
    return loading(
        episodesList, seriesList, channelsList, searchKeyword, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        loading,
  }) {
    return loading?.call(
        episodesList, seriesList, channelsList, searchKeyword, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        content,
    TResult Function(
            List<Episode> episodesList,
            List<Series> seriesList,
            List<Channel> channelsList,
            String searchKeyword,
            Supplements supplements)?
        loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(
          episodesList, seriesList, channelsList, searchKeyword, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Content value) content,
    required TResult Function(_Loading value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Content value)? content,
    TResult Function(_Loading value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Content value)? content,
    TResult Function(_Loading value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SearchPageState {
  const factory _Loading(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements) = _$_Loading;

  @override
  List<Episode> get episodesList => throw _privateConstructorUsedError;
  @override
  List<Series> get seriesList => throw _privateConstructorUsedError;
  @override
  List<Channel> get channelsList => throw _privateConstructorUsedError;
  @override
  String get searchKeyword => throw _privateConstructorUsedError;
  @override
  Supplements get supplements => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

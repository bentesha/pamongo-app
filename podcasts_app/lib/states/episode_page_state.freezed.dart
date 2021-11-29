// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'episode_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$EpisodePageStateTearOff {
  const _$EpisodePageStateTearOff();

  _Loading loading(Episode episode, Supplements supplements) {
    return _Loading(
      episode,
      supplements,
    );
  }

  _Content content(Episode episode, Supplements supplements) {
    return _Content(
      episode,
      supplements,
    );
  }
}

/// @nodoc
const $EpisodePageState = _$EpisodePageStateTearOff();

/// @nodoc
mixin _$EpisodePageState {
  Episode get episode => throw _privateConstructorUsedError;
  Supplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Episode episode, Supplements supplements) loading,
    required TResult Function(Episode episode, Supplements supplements) content,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Episode episode, Supplements supplements)? loading,
    TResult Function(Episode episode, Supplements supplements)? content,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Episode episode, Supplements supplements)? loading,
    TResult Function(Episode episode, Supplements supplements)? content,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EpisodePageStateCopyWith<EpisodePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodePageStateCopyWith<$Res> {
  factory $EpisodePageStateCopyWith(
          EpisodePageState value, $Res Function(EpisodePageState) then) =
      _$EpisodePageStateCopyWithImpl<$Res>;
  $Res call({Episode episode, Supplements supplements});

  $EpisodeCopyWith<$Res> get episode;
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$EpisodePageStateCopyWithImpl<$Res>
    implements $EpisodePageStateCopyWith<$Res> {
  _$EpisodePageStateCopyWithImpl(this._value, this._then);

  final EpisodePageState _value;
  // ignore: unused_field
  final $Res Function(EpisodePageState) _then;

  @override
  $Res call({
    Object? episode = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      episode: episode == freezed
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as Episode,
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }

  @override
  $EpisodeCopyWith<$Res> get episode {
    return $EpisodeCopyWith<$Res>(_value.episode, (value) {
      return _then(_value.copyWith(episode: value));
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
    implements $EpisodePageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({Episode episode, Supplements supplements});

  @override
  $EpisodeCopyWith<$Res> get episode;
  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$EpisodePageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? episode = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Loading(
      episode == freezed
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as Episode,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.episode, this.supplements);

  @override
  final Episode episode;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'EpisodePageState.loading(episode: $episode, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            (identical(other.episode, episode) || other.episode == episode) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(runtimeType, episode, supplements);

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Episode episode, Supplements supplements) loading,
    required TResult Function(Episode episode, Supplements supplements) content,
  }) {
    return loading(episode, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Episode episode, Supplements supplements)? loading,
    TResult Function(Episode episode, Supplements supplements)? content,
  }) {
    return loading?.call(episode, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Episode episode, Supplements supplements)? loading,
    TResult Function(Episode episode, Supplements supplements)? content,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(episode, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements EpisodePageState {
  const factory _Loading(Episode episode, Supplements supplements) = _$_Loading;

  @override
  Episode get episode;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $EpisodePageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({Episode episode, Supplements supplements});

  @override
  $EpisodeCopyWith<$Res> get episode;
  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$EpisodePageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? episode = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      episode == freezed
          ? _value.episode
          : episode // ignore: cast_nullable_to_non_nullable
              as Episode,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.episode, this.supplements);

  @override
  final Episode episode;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'EpisodePageState.content(episode: $episode, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            (identical(other.episode, episode) || other.episode == episode) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(runtimeType, episode, supplements);

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Episode episode, Supplements supplements) loading,
    required TResult Function(Episode episode, Supplements supplements) content,
  }) {
    return content(episode, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Episode episode, Supplements supplements)? loading,
    TResult Function(Episode episode, Supplements supplements)? content,
  }) {
    return content?.call(episode, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Episode episode, Supplements supplements)? loading,
    TResult Function(Episode episode, Supplements supplements)? content,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(episode, supplements);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Content value) content,
  }) {
    return content(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
  }) {
    return content?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Content value)? content,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(this);
    }
    return orElse();
  }
}

abstract class _Content implements EpisodePageState {
  const factory _Content(Episode episode, Supplements supplements) = _$_Content;

  @override
  Episode get episode;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

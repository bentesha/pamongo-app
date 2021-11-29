// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'channel_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChannelPageStateTearOff {
  const _$ChannelPageStateTearOff();

  _Loading loading(Channel channel, Supplements supplements) {
    return _Loading(
      channel,
      supplements,
    );
  }

  _Content content(Channel channel, Supplements supplements) {
    return _Content(
      channel,
      supplements,
    );
  }

  _Failed failed(Channel channel, Supplements supplements) {
    return _Failed(
      channel,
      supplements,
    );
  }
}

/// @nodoc
const $ChannelPageState = _$ChannelPageStateTearOff();

/// @nodoc
mixin _$ChannelPageState {
  Channel get channel => throw _privateConstructorUsedError;
  Supplements get supplements => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Channel channel, Supplements supplements) loading,
    required TResult Function(Channel channel, Supplements supplements) content,
    required TResult Function(Channel channel, Supplements supplements) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Channel channel, Supplements supplements)? loading,
    TResult Function(Channel channel, Supplements supplements)? content,
    TResult Function(Channel channel, Supplements supplements)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Channel channel, Supplements supplements)? loading,
    TResult Function(Channel channel, Supplements supplements)? content,
    TResult Function(Channel channel, Supplements supplements)? failed,
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
  $ChannelPageStateCopyWith<ChannelPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelPageStateCopyWith<$Res> {
  factory $ChannelPageStateCopyWith(
          ChannelPageState value, $Res Function(ChannelPageState) then) =
      _$ChannelPageStateCopyWithImpl<$Res>;
  $Res call({Channel channel, Supplements supplements});

  $ChannelCopyWith<$Res> get channel;
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class _$ChannelPageStateCopyWithImpl<$Res>
    implements $ChannelPageStateCopyWith<$Res> {
  _$ChannelPageStateCopyWithImpl(this._value, this._then);

  final ChannelPageState _value;
  // ignore: unused_field
  final $Res Function(ChannelPageState) _then;

  @override
  $Res call({
    Object? channel = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_value.copyWith(
      channel: channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as Channel,
      supplements: supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }

  @override
  $ChannelCopyWith<$Res> get channel {
    return $ChannelCopyWith<$Res>(_value.channel, (value) {
      return _then(_value.copyWith(channel: value));
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
    implements $ChannelPageStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({Channel channel, Supplements supplements});

  @override
  $ChannelCopyWith<$Res> get channel;
  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$ChannelPageStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? channel = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Loading(
      channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as Channel,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.channel, this.supplements);

  @override
  final Channel channel;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'ChannelPageState.loading(channel: $channel, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Loading &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(runtimeType, channel, supplements);

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Channel channel, Supplements supplements) loading,
    required TResult Function(Channel channel, Supplements supplements) content,
    required TResult Function(Channel channel, Supplements supplements) failed,
  }) {
    return loading(channel, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Channel channel, Supplements supplements)? loading,
    TResult Function(Channel channel, Supplements supplements)? content,
    TResult Function(Channel channel, Supplements supplements)? failed,
  }) {
    return loading?.call(channel, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Channel channel, Supplements supplements)? loading,
    TResult Function(Channel channel, Supplements supplements)? content,
    TResult Function(Channel channel, Supplements supplements)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(channel, supplements);
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

abstract class _Loading implements ChannelPageState {
  const factory _Loading(Channel channel, Supplements supplements) = _$_Loading;

  @override
  Channel get channel;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ContentCopyWith<$Res>
    implements $ChannelPageStateCopyWith<$Res> {
  factory _$ContentCopyWith(_Content value, $Res Function(_Content) then) =
      __$ContentCopyWithImpl<$Res>;
  @override
  $Res call({Channel channel, Supplements supplements});

  @override
  $ChannelCopyWith<$Res> get channel;
  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$ContentCopyWithImpl<$Res> extends _$ChannelPageStateCopyWithImpl<$Res>
    implements _$ContentCopyWith<$Res> {
  __$ContentCopyWithImpl(_Content _value, $Res Function(_Content) _then)
      : super(_value, (v) => _then(v as _Content));

  @override
  _Content get _value => super._value as _Content;

  @override
  $Res call({
    Object? channel = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Content(
      channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as Channel,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Content implements _Content {
  const _$_Content(this.channel, this.supplements);

  @override
  final Channel channel;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'ChannelPageState.content(channel: $channel, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Content &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(runtimeType, channel, supplements);

  @JsonKey(ignore: true)
  @override
  _$ContentCopyWith<_Content> get copyWith =>
      __$ContentCopyWithImpl<_Content>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Channel channel, Supplements supplements) loading,
    required TResult Function(Channel channel, Supplements supplements) content,
    required TResult Function(Channel channel, Supplements supplements) failed,
  }) {
    return content(channel, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Channel channel, Supplements supplements)? loading,
    TResult Function(Channel channel, Supplements supplements)? content,
    TResult Function(Channel channel, Supplements supplements)? failed,
  }) {
    return content?.call(channel, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Channel channel, Supplements supplements)? loading,
    TResult Function(Channel channel, Supplements supplements)? content,
    TResult Function(Channel channel, Supplements supplements)? failed,
    required TResult orElse(),
  }) {
    if (content != null) {
      return content(channel, supplements);
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

abstract class _Content implements ChannelPageState {
  const factory _Content(Channel channel, Supplements supplements) = _$_Content;

  @override
  Channel get channel;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$ContentCopyWith<_Content> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res>
    implements $ChannelPageStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call({Channel channel, Supplements supplements});

  @override
  $ChannelCopyWith<$Res> get channel;
  @override
  $SupplementsCopyWith<$Res> get supplements;
}

/// @nodoc
class __$FailedCopyWithImpl<$Res> extends _$ChannelPageStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? channel = freezed,
    Object? supplements = freezed,
  }) {
    return _then(_Failed(
      channel == freezed
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as Channel,
      supplements == freezed
          ? _value.supplements
          : supplements // ignore: cast_nullable_to_non_nullable
              as Supplements,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.channel, this.supplements);

  @override
  final Channel channel;
  @override
  final Supplements supplements;

  @override
  String toString() {
    return 'ChannelPageState.failed(channel: $channel, supplements: $supplements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.supplements, supplements) ||
                other.supplements == supplements));
  }

  @override
  int get hashCode => Object.hash(runtimeType, channel, supplements);

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Channel channel, Supplements supplements) loading,
    required TResult Function(Channel channel, Supplements supplements) content,
    required TResult Function(Channel channel, Supplements supplements) failed,
  }) {
    return failed(channel, supplements);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(Channel channel, Supplements supplements)? loading,
    TResult Function(Channel channel, Supplements supplements)? content,
    TResult Function(Channel channel, Supplements supplements)? failed,
  }) {
    return failed?.call(channel, supplements);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Channel channel, Supplements supplements)? loading,
    TResult Function(Channel channel, Supplements supplements)? content,
    TResult Function(Channel channel, Supplements supplements)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(channel, supplements);
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

abstract class _Failed implements ChannelPageState {
  const factory _Failed(Channel channel, Supplements supplements) = _$_Failed;

  @override
  Channel get channel;
  @override
  Supplements get supplements;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}

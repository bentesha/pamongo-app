// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'progress_indicator_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProgressIndicatorStateTearOff {
  const _$ProgressIndicatorStateTearOff();

  _Initial initial(ProgressIndicatorContent content, bool isHiding) {
    return _Initial(
      content,
      isHiding,
    );
  }

  _Active active(ProgressIndicatorContent content, bool isHiding) {
    return _Active(
      content,
      isHiding,
    );
  }

  _Failed failed(
      ProgressIndicatorContent content, bool isHiding, AudioError error) {
    return _Failed(
      content,
      isHiding,
      error,
    );
  }
}

/// @nodoc
const $ProgressIndicatorState = _$ProgressIndicatorStateTearOff();

/// @nodoc
mixin _$ProgressIndicatorState {
  ProgressIndicatorContent get content => throw _privateConstructorUsedError;
  bool get isHiding => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content, bool isHiding)
        initial,
    required TResult Function(ProgressIndicatorContent content, bool isHiding)
        active,
    required TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content, bool isHiding)? initial,
    TResult Function(ProgressIndicatorContent content, bool isHiding)? active,
    TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content, bool isHiding)? initial,
    TResult Function(ProgressIndicatorContent content, bool isHiding)? active,
    TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)?
        failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Active value) active,
    required TResult Function(_Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProgressIndicatorStateCopyWith<ProgressIndicatorState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressIndicatorStateCopyWith<$Res> {
  factory $ProgressIndicatorStateCopyWith(ProgressIndicatorState value,
          $Res Function(ProgressIndicatorState) then) =
      _$ProgressIndicatorStateCopyWithImpl<$Res>;
  $Res call({ProgressIndicatorContent content, bool isHiding});

  $ProgressIndicatorContentCopyWith<$Res> get content;
}

/// @nodoc
class _$ProgressIndicatorStateCopyWithImpl<$Res>
    implements $ProgressIndicatorStateCopyWith<$Res> {
  _$ProgressIndicatorStateCopyWithImpl(this._value, this._then);

  final ProgressIndicatorState _value;
  // ignore: unused_field
  final $Res Function(ProgressIndicatorState) _then;

  @override
  $Res call({
    Object? content = freezed,
    Object? isHiding = freezed,
  }) {
    return _then(_value.copyWith(
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
      isHiding: isHiding == freezed
          ? _value.isHiding
          : isHiding // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $ProgressIndicatorContentCopyWith<$Res> get content {
    return $ProgressIndicatorContentCopyWith<$Res>(_value.content, (value) {
      return _then(_value.copyWith(content: value));
    });
  }
}

/// @nodoc
abstract class _$InitialCopyWith<$Res>
    implements $ProgressIndicatorStateCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
  @override
  $Res call({ProgressIndicatorContent content, bool isHiding});

  @override
  $ProgressIndicatorContentCopyWith<$Res> get content;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res>
    extends _$ProgressIndicatorStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;

  @override
  $Res call({
    Object? content = freezed,
    Object? isHiding = freezed,
  }) {
    return _then(_Initial(
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
      isHiding == freezed
          ? _value.isHiding
          : isHiding // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(this.content, this.isHiding);

  @override
  final ProgressIndicatorContent content;
  @override
  final bool isHiding;

  @override
  String toString() {
    return 'ProgressIndicatorState.initial(content: $content, isHiding: $isHiding)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Initial &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isHiding, isHiding) ||
                other.isHiding == isHiding));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, isHiding);

  @JsonKey(ignore: true)
  @override
  _$InitialCopyWith<_Initial> get copyWith =>
      __$InitialCopyWithImpl<_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content, bool isHiding)
        initial,
    required TResult Function(ProgressIndicatorContent content, bool isHiding)
        active,
    required TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)
        failed,
  }) {
    return initial(content, isHiding);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content, bool isHiding)? initial,
    TResult Function(ProgressIndicatorContent content, bool isHiding)? active,
    TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)?
        failed,
  }) {
    return initial?.call(content, isHiding);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content, bool isHiding)? initial,
    TResult Function(ProgressIndicatorContent content, bool isHiding)? active,
    TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)?
        failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(content, isHiding);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Active value) active,
    required TResult Function(_Failed value) failed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Failed value)? failed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements ProgressIndicatorState {
  const factory _Initial(ProgressIndicatorContent content, bool isHiding) =
      _$_Initial;

  @override
  ProgressIndicatorContent get content;
  @override
  bool get isHiding;
  @override
  @JsonKey(ignore: true)
  _$InitialCopyWith<_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ActiveCopyWith<$Res>
    implements $ProgressIndicatorStateCopyWith<$Res> {
  factory _$ActiveCopyWith(_Active value, $Res Function(_Active) then) =
      __$ActiveCopyWithImpl<$Res>;
  @override
  $Res call({ProgressIndicatorContent content, bool isHiding});

  @override
  $ProgressIndicatorContentCopyWith<$Res> get content;
}

/// @nodoc
class __$ActiveCopyWithImpl<$Res>
    extends _$ProgressIndicatorStateCopyWithImpl<$Res>
    implements _$ActiveCopyWith<$Res> {
  __$ActiveCopyWithImpl(_Active _value, $Res Function(_Active) _then)
      : super(_value, (v) => _then(v as _Active));

  @override
  _Active get _value => super._value as _Active;

  @override
  $Res call({
    Object? content = freezed,
    Object? isHiding = freezed,
  }) {
    return _then(_Active(
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
      isHiding == freezed
          ? _value.isHiding
          : isHiding // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Active implements _Active {
  const _$_Active(this.content, this.isHiding);

  @override
  final ProgressIndicatorContent content;
  @override
  final bool isHiding;

  @override
  String toString() {
    return 'ProgressIndicatorState.active(content: $content, isHiding: $isHiding)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Active &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isHiding, isHiding) ||
                other.isHiding == isHiding));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, isHiding);

  @JsonKey(ignore: true)
  @override
  _$ActiveCopyWith<_Active> get copyWith =>
      __$ActiveCopyWithImpl<_Active>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content, bool isHiding)
        initial,
    required TResult Function(ProgressIndicatorContent content, bool isHiding)
        active,
    required TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)
        failed,
  }) {
    return active(content, isHiding);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content, bool isHiding)? initial,
    TResult Function(ProgressIndicatorContent content, bool isHiding)? active,
    TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)?
        failed,
  }) {
    return active?.call(content, isHiding);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content, bool isHiding)? initial,
    TResult Function(ProgressIndicatorContent content, bool isHiding)? active,
    TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)?
        failed,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(content, isHiding);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Active value) active,
    required TResult Function(_Failed value) failed,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Failed value)? failed,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class _Active implements ProgressIndicatorState {
  const factory _Active(ProgressIndicatorContent content, bool isHiding) =
      _$_Active;

  @override
  ProgressIndicatorContent get content;
  @override
  bool get isHiding;
  @override
  @JsonKey(ignore: true)
  _$ActiveCopyWith<_Active> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res>
    implements $ProgressIndicatorStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call(
      {ProgressIndicatorContent content, bool isHiding, AudioError error});

  @override
  $ProgressIndicatorContentCopyWith<$Res> get content;
}

/// @nodoc
class __$FailedCopyWithImpl<$Res>
    extends _$ProgressIndicatorStateCopyWithImpl<$Res>
    implements _$FailedCopyWith<$Res> {
  __$FailedCopyWithImpl(_Failed _value, $Res Function(_Failed) _then)
      : super(_value, (v) => _then(v as _Failed));

  @override
  _Failed get _value => super._value as _Failed;

  @override
  $Res call({
    Object? content = freezed,
    Object? isHiding = freezed,
    Object? error = freezed,
  }) {
    return _then(_Failed(
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
      isHiding == freezed
          ? _value.isHiding
          : isHiding // ignore: cast_nullable_to_non_nullable
              as bool,
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AudioError,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.content, this.isHiding, this.error);

  @override
  final ProgressIndicatorContent content;
  @override
  final bool isHiding;
  @override
  final AudioError error;

  @override
  String toString() {
    return 'ProgressIndicatorState.failed(content: $content, isHiding: $isHiding, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failed &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.isHiding, isHiding) ||
                other.isHiding == isHiding) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, isHiding, error);

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content, bool isHiding)
        initial,
    required TResult Function(ProgressIndicatorContent content, bool isHiding)
        active,
    required TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)
        failed,
  }) {
    return failed(content, isHiding, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content, bool isHiding)? initial,
    TResult Function(ProgressIndicatorContent content, bool isHiding)? active,
    TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)?
        failed,
  }) {
    return failed?.call(content, isHiding, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content, bool isHiding)? initial,
    TResult Function(ProgressIndicatorContent content, bool isHiding)? active,
    TResult Function(
            ProgressIndicatorContent content, bool isHiding, AudioError error)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(content, isHiding, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Active value) active,
    required TResult Function(_Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Active value)? active,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(this);
    }
    return orElse();
  }
}

abstract class _Failed implements ProgressIndicatorState {
  const factory _Failed(
          ProgressIndicatorContent content, bool isHiding, AudioError error) =
      _$_Failed;

  @override
  ProgressIndicatorContent get content;
  @override
  bool get isHiding;
  AudioError get error;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}

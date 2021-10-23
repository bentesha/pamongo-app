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

  _Active active(ProgressIndicatorContent content) {
    return _Active(
      content,
    );
  }

  _Inactive inactive(ProgressIndicatorContent content) {
    return _Inactive(
      content,
    );
  }

  _Loading loading(ProgressIndicatorContent content) {
    return _Loading(
      content,
    );
  }

  _Failed failed(ProgressIndicatorContent content, AudioError error) {
    return _Failed(
      content,
      error,
    );
  }
}

/// @nodoc
const $ProgressIndicatorState = _$ProgressIndicatorStateTearOff();

/// @nodoc
mixin _$ProgressIndicatorState {
  ProgressIndicatorContent get content => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content) active,
    required TResult Function(ProgressIndicatorContent content) inactive,
    required TResult Function(ProgressIndicatorContent content) loading,
    required TResult Function(
            ProgressIndicatorContent content, AudioError error)
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
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
  $Res call({ProgressIndicatorContent content});

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
  }) {
    return _then(_value.copyWith(
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
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
abstract class _$ActiveCopyWith<$Res>
    implements $ProgressIndicatorStateCopyWith<$Res> {
  factory _$ActiveCopyWith(_Active value, $Res Function(_Active) then) =
      __$ActiveCopyWithImpl<$Res>;
  @override
  $Res call({ProgressIndicatorContent content});

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
  }) {
    return _then(_Active(
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
    ));
  }
}

/// @nodoc

class _$_Active implements _Active {
  const _$_Active(this.content);

  @override
  final ProgressIndicatorContent content;

  @override
  String toString() {
    return 'ProgressIndicatorState.active(content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Active &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(other.content, content)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(content);

  @JsonKey(ignore: true)
  @override
  _$ActiveCopyWith<_Active> get copyWith =>
      __$ActiveCopyWithImpl<_Active>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content) active,
    required TResult Function(ProgressIndicatorContent content) inactive,
    required TResult Function(ProgressIndicatorContent content) loading,
    required TResult Function(
            ProgressIndicatorContent content, AudioError error)
        failed,
  }) {
    return active(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
  }) {
    return active?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
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
  const factory _Active(ProgressIndicatorContent content) = _$_Active;

  @override
  ProgressIndicatorContent get content => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ActiveCopyWith<_Active> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$InactiveCopyWith<$Res>
    implements $ProgressIndicatorStateCopyWith<$Res> {
  factory _$InactiveCopyWith(_Inactive value, $Res Function(_Inactive) then) =
      __$InactiveCopyWithImpl<$Res>;
  @override
  $Res call({ProgressIndicatorContent content});

  @override
  $ProgressIndicatorContentCopyWith<$Res> get content;
}

/// @nodoc
class __$InactiveCopyWithImpl<$Res>
    extends _$ProgressIndicatorStateCopyWithImpl<$Res>
    implements _$InactiveCopyWith<$Res> {
  __$InactiveCopyWithImpl(_Inactive _value, $Res Function(_Inactive) _then)
      : super(_value, (v) => _then(v as _Inactive));

  @override
  _Inactive get _value => super._value as _Inactive;

  @override
  $Res call({
    Object? content = freezed,
  }) {
    return _then(_Inactive(
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
    ));
  }
}

/// @nodoc

class _$_Inactive implements _Inactive {
  const _$_Inactive(this.content);

  @override
  final ProgressIndicatorContent content;

  @override
  String toString() {
    return 'ProgressIndicatorState.inactive(content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Inactive &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(other.content, content)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(content);

  @JsonKey(ignore: true)
  @override
  _$InactiveCopyWith<_Inactive> get copyWith =>
      __$InactiveCopyWithImpl<_Inactive>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content) active,
    required TResult Function(ProgressIndicatorContent content) inactive,
    required TResult Function(ProgressIndicatorContent content) loading,
    required TResult Function(
            ProgressIndicatorContent content, AudioError error)
        failed,
  }) {
    return inactive(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
  }) {
    return inactive?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
  }) {
    return inactive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
  }) {
    return inactive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (inactive != null) {
      return inactive(this);
    }
    return orElse();
  }
}

abstract class _Inactive implements ProgressIndicatorState {
  const factory _Inactive(ProgressIndicatorContent content) = _$_Inactive;

  @override
  ProgressIndicatorContent get content => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$InactiveCopyWith<_Inactive> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res>
    implements $ProgressIndicatorStateCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
  @override
  $Res call({ProgressIndicatorContent content});

  @override
  $ProgressIndicatorContentCopyWith<$Res> get content;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    extends _$ProgressIndicatorStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;

  @override
  $Res call({
    Object? content = freezed,
  }) {
    return _then(_Loading(
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
    ));
  }
}

/// @nodoc

class _$_Loading implements _Loading {
  const _$_Loading(this.content);

  @override
  final ProgressIndicatorContent content;

  @override
  String toString() {
    return 'ProgressIndicatorState.loading(content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Loading &&
            (identical(other.content, content) ||
                const DeepCollectionEquality().equals(other.content, content)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(content);

  @JsonKey(ignore: true)
  @override
  _$LoadingCopyWith<_Loading> get copyWith =>
      __$LoadingCopyWithImpl<_Loading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content) active,
    required TResult Function(ProgressIndicatorContent content) inactive,
    required TResult Function(ProgressIndicatorContent content) loading,
    required TResult Function(
            ProgressIndicatorContent content, AudioError error)
        failed,
  }) {
    return loading(content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
  }) {
    return loading?.call(content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements ProgressIndicatorState {
  const factory _Loading(ProgressIndicatorContent content) = _$_Loading;

  @override
  ProgressIndicatorContent get content => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoadingCopyWith<_Loading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailedCopyWith<$Res>
    implements $ProgressIndicatorStateCopyWith<$Res> {
  factory _$FailedCopyWith(_Failed value, $Res Function(_Failed) then) =
      __$FailedCopyWithImpl<$Res>;
  @override
  $Res call({ProgressIndicatorContent content, AudioError error});

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
    Object? error = freezed,
  }) {
    return _then(_Failed(
      content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as ProgressIndicatorContent,
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as AudioError,
    ));
  }
}

/// @nodoc

class _$_Failed implements _Failed {
  const _$_Failed(this.content, this.error);

  @override
  final ProgressIndicatorContent content;
  @override
  final AudioError error;

  @override
  String toString() {
    return 'ProgressIndicatorState.failed(content: $content, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Failed &&
            (identical(other.content, content) ||
                const DeepCollectionEquality()
                    .equals(other.content, content)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(content) ^
      const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$FailedCopyWith<_Failed> get copyWith =>
      __$FailedCopyWithImpl<_Failed>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(ProgressIndicatorContent content) active,
    required TResult Function(ProgressIndicatorContent content) inactive,
    required TResult Function(ProgressIndicatorContent content) loading,
    required TResult Function(
            ProgressIndicatorContent content, AudioError error)
        failed,
  }) {
    return failed(content, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
  }) {
    return failed?.call(content, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(ProgressIndicatorContent content)? active,
    TResult Function(ProgressIndicatorContent content)? inactive,
    TResult Function(ProgressIndicatorContent content)? loading,
    TResult Function(ProgressIndicatorContent content, AudioError error)?
        failed,
    required TResult orElse(),
  }) {
    if (failed != null) {
      return failed(content, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Active value) active,
    required TResult Function(_Inactive value) inactive,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Failed value) failed,
  }) {
    return failed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
    TResult Function(_Failed value)? failed,
  }) {
    return failed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Active value)? active,
    TResult Function(_Inactive value)? inactive,
    TResult Function(_Loading value)? loading,
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
  const factory _Failed(ProgressIndicatorContent content, AudioError error) =
      _$_Failed;

  @override
  ProgressIndicatorContent get content => throw _privateConstructorUsedError;
  AudioError get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FailedCopyWith<_Failed> get copyWith => throw _privateConstructorUsedError;
}

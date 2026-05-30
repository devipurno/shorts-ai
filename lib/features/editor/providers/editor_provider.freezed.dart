// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditorState {
  String get videoId;
  String get videoUrl;
  int get trimStartMs;
  int get trimEndMs;
  List<int> get splits;
  double get speed;
  MusicTrack? get musicTrack;
  WatermarkConfig get watermark;
  FilterPreset get filter;
  ExportConfig get exportConfig;
  bool get isExporting;
  int get exportProgress;
  String? get outputPath;
  String? get errorMessage;

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditorStateCopyWith<EditorState> get copyWith =>
      _$EditorStateCopyWithImpl<EditorState>(this as EditorState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditorState &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.trimStartMs, trimStartMs) ||
                other.trimStartMs == trimStartMs) &&
            (identical(other.trimEndMs, trimEndMs) ||
                other.trimEndMs == trimEndMs) &&
            const DeepCollectionEquality().equals(other.splits, splits) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.musicTrack, musicTrack) ||
                other.musicTrack == musicTrack) &&
            (identical(other.watermark, watermark) ||
                other.watermark == watermark) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.exportConfig, exportConfig) ||
                other.exportConfig == exportConfig) &&
            (identical(other.isExporting, isExporting) ||
                other.isExporting == isExporting) &&
            (identical(other.exportProgress, exportProgress) ||
                other.exportProgress == exportProgress) &&
            (identical(other.outputPath, outputPath) ||
                other.outputPath == outputPath) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      videoId,
      videoUrl,
      trimStartMs,
      trimEndMs,
      const DeepCollectionEquality().hash(splits),
      speed,
      musicTrack,
      watermark,
      filter,
      exportConfig,
      isExporting,
      exportProgress,
      outputPath,
      errorMessage);

  @override
  String toString() {
    return 'EditorState(videoId: $videoId, videoUrl: $videoUrl, trimStartMs: $trimStartMs, trimEndMs: $trimEndMs, splits: $splits, speed: $speed, musicTrack: $musicTrack, watermark: $watermark, filter: $filter, exportConfig: $exportConfig, isExporting: $isExporting, exportProgress: $exportProgress, outputPath: $outputPath, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $EditorStateCopyWith<$Res> {
  factory $EditorStateCopyWith(
          EditorState value, $Res Function(EditorState) _then) =
      _$EditorStateCopyWithImpl;
  @useResult
  $Res call(
      {String videoId,
      String videoUrl,
      int trimStartMs,
      int trimEndMs,
      List<int> splits,
      double speed,
      MusicTrack? musicTrack,
      WatermarkConfig watermark,
      FilterPreset filter,
      ExportConfig exportConfig,
      bool isExporting,
      int exportProgress,
      String? outputPath,
      String? errorMessage});

  $MusicTrackCopyWith<$Res>? get musicTrack;
  $WatermarkConfigCopyWith<$Res> get watermark;
  $ExportConfigCopyWith<$Res> get exportConfig;
}

/// @nodoc
class _$EditorStateCopyWithImpl<$Res> implements $EditorStateCopyWith<$Res> {
  _$EditorStateCopyWithImpl(this._self, this._then);

  final EditorState _self;
  final $Res Function(EditorState) _then;

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? videoUrl = null,
    Object? trimStartMs = null,
    Object? trimEndMs = null,
    Object? splits = null,
    Object? speed = null,
    Object? musicTrack = freezed,
    Object? watermark = null,
    Object? filter = null,
    Object? exportConfig = null,
    Object? isExporting = null,
    Object? exportProgress = null,
    Object? outputPath = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      videoId: null == videoId
          ? _self.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      trimStartMs: null == trimStartMs
          ? _self.trimStartMs
          : trimStartMs // ignore: cast_nullable_to_non_nullable
              as int,
      trimEndMs: null == trimEndMs
          ? _self.trimEndMs
          : trimEndMs // ignore: cast_nullable_to_non_nullable
              as int,
      splits: null == splits
          ? _self.splits
          : splits // ignore: cast_nullable_to_non_nullable
              as List<int>,
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      musicTrack: freezed == musicTrack
          ? _self.musicTrack
          : musicTrack // ignore: cast_nullable_to_non_nullable
              as MusicTrack?,
      watermark: null == watermark
          ? _self.watermark
          : watermark // ignore: cast_nullable_to_non_nullable
              as WatermarkConfig,
      filter: null == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FilterPreset,
      exportConfig: null == exportConfig
          ? _self.exportConfig
          : exportConfig // ignore: cast_nullable_to_non_nullable
              as ExportConfig,
      isExporting: null == isExporting
          ? _self.isExporting
          : isExporting // ignore: cast_nullable_to_non_nullable
              as bool,
      exportProgress: null == exportProgress
          ? _self.exportProgress
          : exportProgress // ignore: cast_nullable_to_non_nullable
              as int,
      outputPath: freezed == outputPath
          ? _self.outputPath
          : outputPath // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MusicTrackCopyWith<$Res>? get musicTrack {
    if (_self.musicTrack == null) {
      return null;
    }

    return $MusicTrackCopyWith<$Res>(_self.musicTrack!, (value) {
      return _then(_self.copyWith(musicTrack: value));
    });
  }

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WatermarkConfigCopyWith<$Res> get watermark {
    return $WatermarkConfigCopyWith<$Res>(_self.watermark, (value) {
      return _then(_self.copyWith(watermark: value));
    });
  }

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExportConfigCopyWith<$Res> get exportConfig {
    return $ExportConfigCopyWith<$Res>(_self.exportConfig, (value) {
      return _then(_self.copyWith(exportConfig: value));
    });
  }
}

/// Adds pattern-matching-related methods to [EditorState].
extension EditorStatePatterns on EditorState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_EditorState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditorState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_EditorState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditorState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_EditorState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditorState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String videoId,
            String videoUrl,
            int trimStartMs,
            int trimEndMs,
            List<int> splits,
            double speed,
            MusicTrack? musicTrack,
            WatermarkConfig watermark,
            FilterPreset filter,
            ExportConfig exportConfig,
            bool isExporting,
            int exportProgress,
            String? outputPath,
            String? errorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditorState() when $default != null:
        return $default(
            _that.videoId,
            _that.videoUrl,
            _that.trimStartMs,
            _that.trimEndMs,
            _that.splits,
            _that.speed,
            _that.musicTrack,
            _that.watermark,
            _that.filter,
            _that.exportConfig,
            _that.isExporting,
            _that.exportProgress,
            _that.outputPath,
            _that.errorMessage);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String videoId,
            String videoUrl,
            int trimStartMs,
            int trimEndMs,
            List<int> splits,
            double speed,
            MusicTrack? musicTrack,
            WatermarkConfig watermark,
            FilterPreset filter,
            ExportConfig exportConfig,
            bool isExporting,
            int exportProgress,
            String? outputPath,
            String? errorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditorState():
        return $default(
            _that.videoId,
            _that.videoUrl,
            _that.trimStartMs,
            _that.trimEndMs,
            _that.splits,
            _that.speed,
            _that.musicTrack,
            _that.watermark,
            _that.filter,
            _that.exportConfig,
            _that.isExporting,
            _that.exportProgress,
            _that.outputPath,
            _that.errorMessage);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String videoId,
            String videoUrl,
            int trimStartMs,
            int trimEndMs,
            List<int> splits,
            double speed,
            MusicTrack? musicTrack,
            WatermarkConfig watermark,
            FilterPreset filter,
            ExportConfig exportConfig,
            bool isExporting,
            int exportProgress,
            String? outputPath,
            String? errorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditorState() when $default != null:
        return $default(
            _that.videoId,
            _that.videoUrl,
            _that.trimStartMs,
            _that.trimEndMs,
            _that.splits,
            _that.speed,
            _that.musicTrack,
            _that.watermark,
            _that.filter,
            _that.exportConfig,
            _that.isExporting,
            _that.exportProgress,
            _that.outputPath,
            _that.errorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _EditorState implements EditorState {
  const _EditorState(
      {required this.videoId,
      this.videoUrl = '',
      this.trimStartMs = 0,
      this.trimEndMs = 60000,
      final List<int> splits = const <int>[],
      this.speed = 1.0,
      this.musicTrack,
      this.watermark = const WatermarkConfig(),
      this.filter = FilterPreset.none,
      this.exportConfig = const ExportConfig(),
      this.isExporting = false,
      this.exportProgress = 0,
      this.outputPath,
      this.errorMessage})
      : _splits = splits;

  @override
  final String videoId;
  @override
  @JsonKey()
  final String videoUrl;
  @override
  @JsonKey()
  final int trimStartMs;
  @override
  @JsonKey()
  final int trimEndMs;
  final List<int> _splits;
  @override
  @JsonKey()
  List<int> get splits {
    if (_splits is EqualUnmodifiableListView) return _splits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_splits);
  }

  @override
  @JsonKey()
  final double speed;
  @override
  final MusicTrack? musicTrack;
  @override
  @JsonKey()
  final WatermarkConfig watermark;
  @override
  @JsonKey()
  final FilterPreset filter;
  @override
  @JsonKey()
  final ExportConfig exportConfig;
  @override
  @JsonKey()
  final bool isExporting;
  @override
  @JsonKey()
  final int exportProgress;
  @override
  final String? outputPath;
  @override
  final String? errorMessage;

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EditorStateCopyWith<_EditorState> get copyWith =>
      __$EditorStateCopyWithImpl<_EditorState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditorState &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.trimStartMs, trimStartMs) ||
                other.trimStartMs == trimStartMs) &&
            (identical(other.trimEndMs, trimEndMs) ||
                other.trimEndMs == trimEndMs) &&
            const DeepCollectionEquality().equals(other._splits, _splits) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.musicTrack, musicTrack) ||
                other.musicTrack == musicTrack) &&
            (identical(other.watermark, watermark) ||
                other.watermark == watermark) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.exportConfig, exportConfig) ||
                other.exportConfig == exportConfig) &&
            (identical(other.isExporting, isExporting) ||
                other.isExporting == isExporting) &&
            (identical(other.exportProgress, exportProgress) ||
                other.exportProgress == exportProgress) &&
            (identical(other.outputPath, outputPath) ||
                other.outputPath == outputPath) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      videoId,
      videoUrl,
      trimStartMs,
      trimEndMs,
      const DeepCollectionEquality().hash(_splits),
      speed,
      musicTrack,
      watermark,
      filter,
      exportConfig,
      isExporting,
      exportProgress,
      outputPath,
      errorMessage);

  @override
  String toString() {
    return 'EditorState(videoId: $videoId, videoUrl: $videoUrl, trimStartMs: $trimStartMs, trimEndMs: $trimEndMs, splits: $splits, speed: $speed, musicTrack: $musicTrack, watermark: $watermark, filter: $filter, exportConfig: $exportConfig, isExporting: $isExporting, exportProgress: $exportProgress, outputPath: $outputPath, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$EditorStateCopyWith<$Res>
    implements $EditorStateCopyWith<$Res> {
  factory _$EditorStateCopyWith(
          _EditorState value, $Res Function(_EditorState) _then) =
      __$EditorStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String videoId,
      String videoUrl,
      int trimStartMs,
      int trimEndMs,
      List<int> splits,
      double speed,
      MusicTrack? musicTrack,
      WatermarkConfig watermark,
      FilterPreset filter,
      ExportConfig exportConfig,
      bool isExporting,
      int exportProgress,
      String? outputPath,
      String? errorMessage});

  @override
  $MusicTrackCopyWith<$Res>? get musicTrack;
  @override
  $WatermarkConfigCopyWith<$Res> get watermark;
  @override
  $ExportConfigCopyWith<$Res> get exportConfig;
}

/// @nodoc
class __$EditorStateCopyWithImpl<$Res> implements _$EditorStateCopyWith<$Res> {
  __$EditorStateCopyWithImpl(this._self, this._then);

  final _EditorState _self;
  final $Res Function(_EditorState) _then;

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? videoId = null,
    Object? videoUrl = null,
    Object? trimStartMs = null,
    Object? trimEndMs = null,
    Object? splits = null,
    Object? speed = null,
    Object? musicTrack = freezed,
    Object? watermark = null,
    Object? filter = null,
    Object? exportConfig = null,
    Object? isExporting = null,
    Object? exportProgress = null,
    Object? outputPath = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_EditorState(
      videoId: null == videoId
          ? _self.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _self.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      trimStartMs: null == trimStartMs
          ? _self.trimStartMs
          : trimStartMs // ignore: cast_nullable_to_non_nullable
              as int,
      trimEndMs: null == trimEndMs
          ? _self.trimEndMs
          : trimEndMs // ignore: cast_nullable_to_non_nullable
              as int,
      splits: null == splits
          ? _self._splits
          : splits // ignore: cast_nullable_to_non_nullable
              as List<int>,
      speed: null == speed
          ? _self.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double,
      musicTrack: freezed == musicTrack
          ? _self.musicTrack
          : musicTrack // ignore: cast_nullable_to_non_nullable
              as MusicTrack?,
      watermark: null == watermark
          ? _self.watermark
          : watermark // ignore: cast_nullable_to_non_nullable
              as WatermarkConfig,
      filter: null == filter
          ? _self.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as FilterPreset,
      exportConfig: null == exportConfig
          ? _self.exportConfig
          : exportConfig // ignore: cast_nullable_to_non_nullable
              as ExportConfig,
      isExporting: null == isExporting
          ? _self.isExporting
          : isExporting // ignore: cast_nullable_to_non_nullable
              as bool,
      exportProgress: null == exportProgress
          ? _self.exportProgress
          : exportProgress // ignore: cast_nullable_to_non_nullable
              as int,
      outputPath: freezed == outputPath
          ? _self.outputPath
          : outputPath // ignore: cast_nullable_to_non_nullable
              as String?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MusicTrackCopyWith<$Res>? get musicTrack {
    if (_self.musicTrack == null) {
      return null;
    }

    return $MusicTrackCopyWith<$Res>(_self.musicTrack!, (value) {
      return _then(_self.copyWith(musicTrack: value));
    });
  }

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WatermarkConfigCopyWith<$Res> get watermark {
    return $WatermarkConfigCopyWith<$Res>(_self.watermark, (value) {
      return _then(_self.copyWith(watermark: value));
    });
  }

  /// Create a copy of EditorState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExportConfigCopyWith<$Res> get exportConfig {
    return $ExportConfigCopyWith<$Res>(_self.exportConfig, (value) {
      return _then(_self.copyWith(exportConfig: value));
    });
  }
}

/// @nodoc
mixin _$MusicTrack {
  String get id;
  String get title;
  String? get localPath;
  double get volume;
  MusicFade get fade;

  /// Create a copy of MusicTrack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MusicTrackCopyWith<MusicTrack> get copyWith =>
      _$MusicTrackCopyWithImpl<MusicTrack>(this as MusicTrack, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MusicTrack &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.fade, fade) || other.fade == fade));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, localPath, volume, fade);

  @override
  String toString() {
    return 'MusicTrack(id: $id, title: $title, localPath: $localPath, volume: $volume, fade: $fade)';
  }
}

/// @nodoc
abstract mixin class $MusicTrackCopyWith<$Res> {
  factory $MusicTrackCopyWith(
          MusicTrack value, $Res Function(MusicTrack) _then) =
      _$MusicTrackCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String? localPath,
      double volume,
      MusicFade fade});
}

/// @nodoc
class _$MusicTrackCopyWithImpl<$Res> implements $MusicTrackCopyWith<$Res> {
  _$MusicTrackCopyWithImpl(this._self, this._then);

  final MusicTrack _self;
  final $Res Function(MusicTrack) _then;

  /// Create a copy of MusicTrack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? localPath = freezed,
    Object? volume = null,
    Object? fade = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: freezed == localPath
          ? _self.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      fade: null == fade
          ? _self.fade
          : fade // ignore: cast_nullable_to_non_nullable
              as MusicFade,
    ));
  }
}

/// Adds pattern-matching-related methods to [MusicTrack].
extension MusicTrackPatterns on MusicTrack {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MusicTrack value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MusicTrack() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MusicTrack value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MusicTrack():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MusicTrack value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MusicTrack() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(String id, String title, String? localPath, double volume,
            MusicFade fade)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MusicTrack() when $default != null:
        return $default(
            _that.id, _that.title, _that.localPath, _that.volume, _that.fade);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(String id, String title, String? localPath, double volume,
            MusicFade fade)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MusicTrack():
        return $default(
            _that.id, _that.title, _that.localPath, _that.volume, _that.fade);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(String id, String title, String? localPath, double volume,
            MusicFade fade)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MusicTrack() when $default != null:
        return $default(
            _that.id, _that.title, _that.localPath, _that.volume, _that.fade);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MusicTrack implements MusicTrack {
  const _MusicTrack(
      {required this.id,
      required this.title,
      this.localPath,
      this.volume = 0.7,
      this.fade = MusicFade.none});

  @override
  final String id;
  @override
  final String title;
  @override
  final String? localPath;
  @override
  @JsonKey()
  final double volume;
  @override
  @JsonKey()
  final MusicFade fade;

  /// Create a copy of MusicTrack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MusicTrackCopyWith<_MusicTrack> get copyWith =>
      __$MusicTrackCopyWithImpl<_MusicTrack>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MusicTrack &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.fade, fade) || other.fade == fade));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, localPath, volume, fade);

  @override
  String toString() {
    return 'MusicTrack(id: $id, title: $title, localPath: $localPath, volume: $volume, fade: $fade)';
  }
}

/// @nodoc
abstract mixin class _$MusicTrackCopyWith<$Res>
    implements $MusicTrackCopyWith<$Res> {
  factory _$MusicTrackCopyWith(
          _MusicTrack value, $Res Function(_MusicTrack) _then) =
      __$MusicTrackCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? localPath,
      double volume,
      MusicFade fade});
}

/// @nodoc
class __$MusicTrackCopyWithImpl<$Res> implements _$MusicTrackCopyWith<$Res> {
  __$MusicTrackCopyWithImpl(this._self, this._then);

  final _MusicTrack _self;
  final $Res Function(_MusicTrack) _then;

  /// Create a copy of MusicTrack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? localPath = freezed,
    Object? volume = null,
    Object? fade = null,
  }) {
    return _then(_MusicTrack(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      localPath: freezed == localPath
          ? _self.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      volume: null == volume
          ? _self.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      fade: null == fade
          ? _self.fade
          : fade // ignore: cast_nullable_to_non_nullable
              as MusicFade,
    ));
  }
}

/// @nodoc
mixin _$WatermarkConfig {
  WatermarkType get type;
  String get text;
  String? get logoPath;
  WatermarkPosition get position;
  double get opacity;
  double get size;
  Color get color;

  /// Create a copy of WatermarkConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WatermarkConfigCopyWith<WatermarkConfig> get copyWith =>
      _$WatermarkConfigCopyWithImpl<WatermarkConfig>(
          this as WatermarkConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WatermarkConfig &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.logoPath, logoPath) ||
                other.logoPath == logoPath) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.opacity, opacity) || other.opacity == opacity) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, text, logoPath, position, opacity, size, color);

  @override
  String toString() {
    return 'WatermarkConfig(type: $type, text: $text, logoPath: $logoPath, position: $position, opacity: $opacity, size: $size, color: $color)';
  }
}

/// @nodoc
abstract mixin class $WatermarkConfigCopyWith<$Res> {
  factory $WatermarkConfigCopyWith(
          WatermarkConfig value, $Res Function(WatermarkConfig) _then) =
      _$WatermarkConfigCopyWithImpl;
  @useResult
  $Res call(
      {WatermarkType type,
      String text,
      String? logoPath,
      WatermarkPosition position,
      double opacity,
      double size,
      Color color});
}

/// @nodoc
class _$WatermarkConfigCopyWithImpl<$Res>
    implements $WatermarkConfigCopyWith<$Res> {
  _$WatermarkConfigCopyWithImpl(this._self, this._then);

  final WatermarkConfig _self;
  final $Res Function(WatermarkConfig) _then;

  /// Create a copy of WatermarkConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? text = null,
    Object? logoPath = freezed,
    Object? position = null,
    Object? opacity = null,
    Object? size = null,
    Object? color = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as WatermarkType,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      logoPath: freezed == logoPath
          ? _self.logoPath
          : logoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as WatermarkPosition,
      opacity: null == opacity
          ? _self.opacity
          : opacity // ignore: cast_nullable_to_non_nullable
              as double,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// Adds pattern-matching-related methods to [WatermarkConfig].
extension WatermarkConfigPatterns on WatermarkConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_WatermarkConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatermarkConfig() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_WatermarkConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatermarkConfig():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_WatermarkConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatermarkConfig() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            WatermarkType type,
            String text,
            String? logoPath,
            WatermarkPosition position,
            double opacity,
            double size,
            Color color)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _WatermarkConfig() when $default != null:
        return $default(_that.type, _that.text, _that.logoPath, _that.position,
            _that.opacity, _that.size, _that.color);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            WatermarkType type,
            String text,
            String? logoPath,
            WatermarkPosition position,
            double opacity,
            double size,
            Color color)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatermarkConfig():
        return $default(_that.type, _that.text, _that.logoPath, _that.position,
            _that.opacity, _that.size, _that.color);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            WatermarkType type,
            String text,
            String? logoPath,
            WatermarkPosition position,
            double opacity,
            double size,
            Color color)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _WatermarkConfig() when $default != null:
        return $default(_that.type, _that.text, _that.logoPath, _that.position,
            _that.opacity, _that.size, _that.color);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _WatermarkConfig implements WatermarkConfig {
  const _WatermarkConfig(
      {this.type = WatermarkType.text,
      this.text = 'AutoShort',
      this.logoPath,
      this.position = WatermarkPosition.bottomRight,
      this.opacity = 0.72,
      this.size = 0.18,
      this.color = const Color(0xFFFFFFFF)});

  @override
  @JsonKey()
  final WatermarkType type;
  @override
  @JsonKey()
  final String text;
  @override
  final String? logoPath;
  @override
  @JsonKey()
  final WatermarkPosition position;
  @override
  @JsonKey()
  final double opacity;
  @override
  @JsonKey()
  final double size;
  @override
  @JsonKey()
  final Color color;

  /// Create a copy of WatermarkConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WatermarkConfigCopyWith<_WatermarkConfig> get copyWith =>
      __$WatermarkConfigCopyWithImpl<_WatermarkConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WatermarkConfig &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.logoPath, logoPath) ||
                other.logoPath == logoPath) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.opacity, opacity) || other.opacity == opacity) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, type, text, logoPath, position, opacity, size, color);

  @override
  String toString() {
    return 'WatermarkConfig(type: $type, text: $text, logoPath: $logoPath, position: $position, opacity: $opacity, size: $size, color: $color)';
  }
}

/// @nodoc
abstract mixin class _$WatermarkConfigCopyWith<$Res>
    implements $WatermarkConfigCopyWith<$Res> {
  factory _$WatermarkConfigCopyWith(
          _WatermarkConfig value, $Res Function(_WatermarkConfig) _then) =
      __$WatermarkConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {WatermarkType type,
      String text,
      String? logoPath,
      WatermarkPosition position,
      double opacity,
      double size,
      Color color});
}

/// @nodoc
class __$WatermarkConfigCopyWithImpl<$Res>
    implements _$WatermarkConfigCopyWith<$Res> {
  __$WatermarkConfigCopyWithImpl(this._self, this._then);

  final _WatermarkConfig _self;
  final $Res Function(_WatermarkConfig) _then;

  /// Create a copy of WatermarkConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? text = null,
    Object? logoPath = freezed,
    Object? position = null,
    Object? opacity = null,
    Object? size = null,
    Object? color = null,
  }) {
    return _then(_WatermarkConfig(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as WatermarkType,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      logoPath: freezed == logoPath
          ? _self.logoPath
          : logoPath // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _self.position
          : position // ignore: cast_nullable_to_non_nullable
              as WatermarkPosition,
      opacity: null == opacity
          ? _self.opacity
          : opacity // ignore: cast_nullable_to_non_nullable
              as double,
      size: null == size
          ? _self.size
          : size // ignore: cast_nullable_to_non_nullable
              as double,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
mixin _$ExportConfig {
  ExportResolution get resolution;
  int get bitrateMbps;
  ExportFormat get format;

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExportConfigCopyWith<ExportConfig> get copyWith =>
      _$ExportConfigCopyWithImpl<ExportConfig>(
          this as ExportConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExportConfig &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.bitrateMbps, bitrateMbps) ||
                other.bitrateMbps == bitrateMbps) &&
            (identical(other.format, format) || other.format == format));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resolution, bitrateMbps, format);

  @override
  String toString() {
    return 'ExportConfig(resolution: $resolution, bitrateMbps: $bitrateMbps, format: $format)';
  }
}

/// @nodoc
abstract mixin class $ExportConfigCopyWith<$Res> {
  factory $ExportConfigCopyWith(
          ExportConfig value, $Res Function(ExportConfig) _then) =
      _$ExportConfigCopyWithImpl;
  @useResult
  $Res call(
      {ExportResolution resolution, int bitrateMbps, ExportFormat format});
}

/// @nodoc
class _$ExportConfigCopyWithImpl<$Res> implements $ExportConfigCopyWith<$Res> {
  _$ExportConfigCopyWithImpl(this._self, this._then);

  final ExportConfig _self;
  final $Res Function(ExportConfig) _then;

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? resolution = null,
    Object? bitrateMbps = null,
    Object? format = null,
  }) {
    return _then(_self.copyWith(
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as ExportResolution,
      bitrateMbps: null == bitrateMbps
          ? _self.bitrateMbps
          : bitrateMbps // ignore: cast_nullable_to_non_nullable
              as int,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as ExportFormat,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExportConfig].
extension ExportConfigPatterns on ExportConfig {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ExportConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExportConfig() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ExportConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExportConfig():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ExportConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExportConfig() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            ExportResolution resolution, int bitrateMbps, ExportFormat format)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExportConfig() when $default != null:
        return $default(_that.resolution, _that.bitrateMbps, _that.format);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            ExportResolution resolution, int bitrateMbps, ExportFormat format)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExportConfig():
        return $default(_that.resolution, _that.bitrateMbps, _that.format);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            ExportResolution resolution, int bitrateMbps, ExportFormat format)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExportConfig() when $default != null:
        return $default(_that.resolution, _that.bitrateMbps, _that.format);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ExportConfig implements ExportConfig {
  const _ExportConfig(
      {this.resolution = ExportResolution.p1080,
      this.bitrateMbps = 12,
      this.format = ExportFormat.mp4});

  @override
  @JsonKey()
  final ExportResolution resolution;
  @override
  @JsonKey()
  final int bitrateMbps;
  @override
  @JsonKey()
  final ExportFormat format;

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExportConfigCopyWith<_ExportConfig> get copyWith =>
      __$ExportConfigCopyWithImpl<_ExportConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExportConfig &&
            (identical(other.resolution, resolution) ||
                other.resolution == resolution) &&
            (identical(other.bitrateMbps, bitrateMbps) ||
                other.bitrateMbps == bitrateMbps) &&
            (identical(other.format, format) || other.format == format));
  }

  @override
  int get hashCode => Object.hash(runtimeType, resolution, bitrateMbps, format);

  @override
  String toString() {
    return 'ExportConfig(resolution: $resolution, bitrateMbps: $bitrateMbps, format: $format)';
  }
}

/// @nodoc
abstract mixin class _$ExportConfigCopyWith<$Res>
    implements $ExportConfigCopyWith<$Res> {
  factory _$ExportConfigCopyWith(
          _ExportConfig value, $Res Function(_ExportConfig) _then) =
      __$ExportConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ExportResolution resolution, int bitrateMbps, ExportFormat format});
}

/// @nodoc
class __$ExportConfigCopyWithImpl<$Res>
    implements _$ExportConfigCopyWith<$Res> {
  __$ExportConfigCopyWithImpl(this._self, this._then);

  final _ExportConfig _self;
  final $Res Function(_ExportConfig) _then;

  /// Create a copy of ExportConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? resolution = null,
    Object? bitrateMbps = null,
    Object? format = null,
  }) {
    return _then(_ExportConfig(
      resolution: null == resolution
          ? _self.resolution
          : resolution // ignore: cast_nullable_to_non_nullable
              as ExportResolution,
      bitrateMbps: null == bitrateMbps
          ? _self.bitrateMbps
          : bitrateMbps // ignore: cast_nullable_to_non_nullable
              as int,
      format: null == format
          ? _self.format
          : format // ignore: cast_nullable_to_non_nullable
              as ExportFormat,
    ));
  }
}

// dart format on

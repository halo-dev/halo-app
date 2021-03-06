import 'dart:ui' as ui show Image;

import 'package:flutter/material.dart';
import 'package:halo/widget/extended_image/src/extended_image_utils.dart';
import 'package:halo/widget/extended_image/src/gesture/extended_image_gesture_utils.dart';

///
///  extended_image_typedef.dart
///  create by zmtzawqlp on 2019/4/3
///

typedef LoadStateChanged = Widget Function(ExtendedImageState state);

///[rect] is render size
///if return true, it will not paint original image,
typedef BeforePaintImage = bool Function(Canvas canvas, Rect rect, ui.Image image, Paint paint);

typedef AfterPaintImage = void Function(Canvas canvas, Rect rect, ui.Image image, Paint paint);

/// animation call back for inertia drag
typedef GestureOffsetAnimationCallBack = void Function(Offset offset);

/// animation call back for scale
typedef GestureScaleAnimationCallBack = void Function(double scale);

/// double tap call back
typedef DoubleTap = void Function(ExtendedImageGestureState state);

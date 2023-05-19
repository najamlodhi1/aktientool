// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import '../../chart/cartesian/axis/spec/axis_spec.dart' show LineStyleSpec;
import '../color.dart' show CustomChartColor;
import '../graphics_factory.dart' show GraphicsFactory;
import '../line_style.dart' show LineStyle;
import '../palette.dart';

// TODO: Implementation of style will change drastically, see bug
// for more details. This is an intermediate step in order to allow overriding
// the default style using style factory.

/// A set of styling rules that determines the default look and feel of charts.
///
/// Get or set the [Style] that is used for the app using [StyleFactory.style].
abstract class Style {
  CustomChartColor get black;

  CustomChartColor get transparent;

  CustomChartColor get white;

  /// Gets list with [count] of palettes.
  List<Palette> getOrderedPalettes(int count);

  /// Creates [LineStyleSpec] for axis line from spec.
  ///
  /// Fill missing value(s) with default.
  LineStyle createAxisLineStyle(
      GraphicsFactory graphicsFactory, LineStyleSpec? spec);

  /// Creates [LineStyleSpec] for tick lines from spec.
  ///
  /// Fill missing value(s) with default.
  LineStyle createTickLineStyle(
      GraphicsFactory graphicsFactory, LineStyleSpec? spec);

  /// Default tick length.
  int get tickLength;

  /// Default tick color.
  CustomChartColor get tickColor;

  ///
  /// Creates [LineStyle] for axis gridlines from spec.
  ///
  /// Fill missing value(s) with default.
  LineStyle createGridlineStyle(
      GraphicsFactory graphicsFactory, LineStyleSpec? spec);

  /// Default color for outside label leader lines for [ArcLabelDecorator].
  CustomChartColor get arcLabelOutsideLeaderLine;

  /// Default series color for legends, used as a fallback when a series has no
  /// data.
  CustomChartColor get defaultSeriesColor;

  /// Default color for strokes for [ArcRendererConfig].
  CustomChartColor get arcStrokeColor;

  /// Default color for entry text for [Legend].
  CustomChartColor get legendEntryTextColor;

  /// Default color for title text for [Legend].
  CustomChartColor get legendTitleTextColor;

  /// Default color for [LinePointHighlighter].
  CustomChartColor get linePointHighlighterColor;

  /// Default color for "no data" states on charts.
  CustomChartColor get noDataColor;

  /// Default color for [RangeAnnotation].
  CustomChartColor get rangeAnnotationColor;

  /// Default fill color for [Slider].
  CustomChartColor get sliderFillColor;

  /// Default stroke color for [Slider].
  CustomChartColor get sliderStrokeColor;

  /// Default background color for the chart.
  CustomChartColor get chartBackgroundColor;

  /// The width of the band specified as fraction of step.
  double get rangeBandSize;
}

import 'package:fancy_factory/src/widget_button.dart';
import 'package:fancy_factory/src/widget_date_range.dart';
import 'package:fancy_factory/src/widget_slider.dart';
import 'package:fancy_factory/src/widget_switch.dart';
import 'package:fancy_factory/src/widget_tag.dart';
import 'package:fancy_factory/src/widget_text_field.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/material.dart'; 

class FormFactory<T> {
  final Disposable bloc;
  final BuildContext context;

  FormFactory({
    @required this.bloc,
    @required this.context,
  })  : assert(bloc != null),
        assert(context != null);

  Widget build(T enumValue, {Map parameters}) {
    if (!isEnum(enumValue)) {
      throw Exception('Only enums allowed');
    }

    final stringValue = enumToString(enumValue);

    if (stringValue.startsWith(enumToString(EnumPrefix.text))) {
      return WidgetTextField<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<TextFieldParameter, dynamic>,
      );
    }
    if (stringValue.startsWith(enumToString(EnumPrefix.action))) {
      return WidgetButton<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<String, dynamic>,
      );
    }
    if (stringValue.startsWith(enumToString(EnumPrefix.dateRange))) {
      return WidgetDateRange<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<DateRangeParameter, dynamic>,
      );
    }

    if (stringValue.startsWith(enumToString(EnumPrefix.bool))) {
      return WidgetSwitch<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<String, dynamic>,
      );
    }

    if (stringValue.startsWith(enumToString(EnumPrefix.slider))) {
      return WidgetSlider<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<SliderParameter, dynamic>,
      );
    }

    if (stringValue.startsWith(enumToString(EnumPrefix.tag))) {
      return WidgetTag<T>(
        bloc: bloc,
        enumValue: enumValue,
        parameters: parameters as Map<String, dynamic>,
      );
    }

    return const Text("Widget Not found :[");
  }
}

extension EnumKey on Object {
  String toYamlKey() {
    return toString()
        .replaceFirst(enumToString(EnumPrefix.action), '')
        .replaceFirst(enumToString(EnumPrefix.text), '')
        .replaceFirst(enumToString(EnumPrefix.dateRange), '')
        .replaceFirst(enumToString(EnumPrefix.bool), '')
        .replaceFirst(enumToString(EnumPrefix.slider), '')
        .replaceFirst(enumToString(EnumPrefix.tag), '')
        .split(".")
        .map((e) => e[0].toLowerCase() + e.substring(1))
        .join(".");
  }
}

enum EnumPrefix { action, text, dateRange, bool, slider, tag }


String enumToString(Object objectEnum) =>
    objectEnum?.toString()?.split('.')?.last;

bool isEnum<T>(T data) {
  final split = data.toString().split('.');
  return split.length > 1 && split[0] == data.runtimeType.toString();
}
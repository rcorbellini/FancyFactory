import 'package:chameleon_resolver/chameleon_resolver.dart';
import 'package:fancy_factory/src/form_factory.dart';
import 'package:fancy_factory/src/widget_component.dart';
import 'package:flutter/material.dart';
import 'package:fancy_stream/fancy_stream.dart';

class WidgetSlider<T extends Object> extends WidgetComponent<SliderParameter> {
  final Fancy bloc;
  final T enumValue;

  const WidgetSlider(
      {Key? key,
      required this.bloc,
      required this.enumValue,
      Map<SliderParameter, dynamic>? parameters})
      : super(key: key, parameters: parameters);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: bloc.streamOf(key: enumValue),
        builder: (date, snapshot) {
          final value = snapshot?.data ?? 1;
          final label =
              "${enumValue.toYamlKey()}.v${value.toInt()}".tr(context);
          return Slider(
            value: value,
            min: getParameter(SliderParameter.min, defaultValue: 1.0),
            max: getParameter(SliderParameter.min, defaultValue: 3.0),
            label: label,
            divisions: getParameter(SliderParameter.division, defaultValue: 2),
            onChanged: (v) => bloc.dispatchOn(v, key: enumValue),
          );
        });
  }
}

enum SliderParameter { min, max, division }

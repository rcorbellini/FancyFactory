import 'package:fancy_factory/src/form_factory.dart';
import 'package:fancy_factory/src/widget_component.dart';
import 'package:flutter/material.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:chameleon_resolver/chameleon_resolver.dart';

class WidgetButton<T extends Object> extends WidgetComponent<String> {
  final Fancy bloc;
  final T enumValue;

  const WidgetButton(
      {required this.bloc,
      required this.enumValue,
      Key? key,
      Map<String, dynamic>? parameters})
      : super(key: key, parameters: parameters);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () => bloc.dispatchOn(enumValue),
        child: Text(enumValue.toYamlKey().tr(context)));
  }
}

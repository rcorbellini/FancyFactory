import 'package:fancy_factory/src/form_factory.dart';
import 'package:fancy_factory/src/reactive_text_builder.dart';
import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/material.dart';
import 'package:chameleon_resolver/chameleon_resolver.dart';

import 'widget_component.dart';

class WidgetTextField<T> extends WidgetComponent<TextFieldParameter> {
  final Disposable bloc;
  final T enumValue;

  const WidgetTextField({
    @required this.bloc,
    @required this.enumValue,
    Map<TextFieldParameter, dynamic> parameters,
    Key key,
  }) : super(key: key, parameters: parameters);
 
  @override
  Widget build(BuildContext context) {
    return ReactiveTextBuilder(
      bloc: bloc,
      keyForm: enumValue,
      builder: (controller, onChanged, error) {
        return TextField(
            decoration: InputDecoration(
              hintText:
                  ChamaleonLocalizations.of(context).translate(enumValue.toYamlKey()),
              errorText: error,
            ),
            obscureText: getParameter(TextFieldParameter.obscureText,
                defaultValue: false),
            onChanged: onChanged,
            controller: controller);
      },
    );
  }
}

enum TextFieldParameter { obscureText }

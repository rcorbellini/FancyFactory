import 'dart:convert';

import 'package:fancy_stream/fancy_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class WidgetTag<T> extends StatelessWidget {
  final T enumValue;
  final Disposable bloc;
  final Map<String, dynamic> parameters;

  const WidgetTag({Key key, this.enumValue, this.bloc, this.parameters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tag>>(
      stream: bloc.streamOf(key: enumValue),
      builder: (date, snapshot) {
        final tags = snapshot.data ?? [];
        return Tags(
          itemCount: tags.length,
          itemBuilder: (int index) {
            return ItemTags(
              singleItem: false,
              title: tags[index].description,
              index: index,
              active: tags[index].selected ?? false,
              onPressed: (itemPressed) {
                final tagsEdited = tags.map((tagItem) {
                  if (tagItem.description == itemPressed.title) {
                    return tagItem.copyWith(selected: itemPressed.active);
                  }
                  return tagItem;
                }).toList();
                bloc.dispatchOn(tagsEdited, key: enumValue);
              },
            );
          },
        );
      },
    );
  }
}

class Tag {
  final String description;
  final bool selected;

  Tag({
    this.description,
    this.selected,
  });

  Tag copyWith({
    String description,
    bool selected,
  }) {
    return Tag(
      description: description ?? this.description,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'selected': selected,
    };
  }

  factory Tag.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Tag(
      description: map['description'],
      selected: map['selected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tag.fromJson(String source) => Tag.fromMap(json.decode(source));

  @override
  String toString() => 'Tag(description: $description, selected: $selected)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Tag &&
      o.description == description &&
      o.selected == selected;
  }

  @override
  int get hashCode => description.hashCode ^ selected.hashCode;
}

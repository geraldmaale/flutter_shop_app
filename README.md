# flutter_shop_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Using JsonSerializable

To generate `*.g.dart` files, run the following command:

- [json_serializable](https://pub.dev/packages/json_serializable)
- [json_annotation](https://pub.dev/packages/json_annotation)

```dart

import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  Category(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.comments,
      this.image});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
```

```bash
flutter pub run build_runner build
```

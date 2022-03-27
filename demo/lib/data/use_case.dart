import 'package:flutter/material.dart';

/// Abstract class for defining a use case that is presented within the demo app.
abstract class UseCase {
  /// The name of the use case.
  final String name;

  /// Description of the use case.
  final String description;

  /// Path to the file containing the sample code of the use case.
  final String? codeFile;

  /// The `Widget` representing a preview of the given use case.
  final Widget? preview;

  const UseCase({
    required this.name,
    required this.description,
    this.codeFile,
    this.preview,
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noteFormKeyProvider =
    Provider.autoDispose<GlobalKey<FormState>>((_) => GlobalKey<FormState>());

final noteTitleProvider =
    Provider.autoDispose<TextEditingController>((_) => TextEditingController());

final noteDescProvider =
    Provider.autoDispose<TextEditingController>((_) => TextEditingController());

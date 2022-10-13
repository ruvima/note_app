import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_app/providers/form_provider.dart';
import 'package:note_app/utils/colors.dart';

class ThemeBottomSheet extends ConsumerWidget {
  const ThemeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> colorList = [
      '#edf095',
      '#f09592',
      '#f0bc92',
      '#ffae6b',
      '#aff296',
      '#6bbd4d',
      '#79edd0',
      '#3fe0b8',
      '#54b4e8',
      '#8b75eb',
      '#eb8bf0',
      '#eb8bf0',
      '#ff2e6d',
    ];
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: ListView.separated(
        itemCount: colorList.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              ref.read(colorProvider.notifier).state = colorList[index];
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor(colorList[index]),
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
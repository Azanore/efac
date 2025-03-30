import 'package:flutter/material.dart';

class CustomScrollbar extends StatelessWidget {
  final ScrollController controller;
  final List<Widget> slivers;
  final EdgeInsetsGeometry padding;

  const CustomScrollbar({
    super.key,
    required this.controller,
    required this.slivers,
    this.padding = const EdgeInsetsDirectional.only(
      start: 16,
      end: 16,
      top: 16,
      bottom: 16,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: Scrollbar(
        controller: controller,
        thumbVisibility: true,
        thickness: 4,
        radius: const Radius.circular(8),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverPadding(
              padding: padding,
              sliver: SliverList(delegate: SliverChildListDelegate(slivers)),
            ),
          ],
        ),
      ),
    );
  }
}

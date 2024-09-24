import 'package:chatnew/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class GradientContainer extends StatelessWidget {
  final Widget? child;

  GradientContainer({super.key, required this.child});

  final MyTheme currentTheme = GetIt.I<MyTheme>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? [
                  Theme.of(context).colorScheme.onSurface,
                  Theme.of(context).colorScheme.onSurface,
                ]
              : [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondary,
                ],
        ),
      ),
      child: child,
    );
  }
}

class InverseGradientContainer extends StatelessWidget {
  final Widget? child;

  InverseGradientContainer({super.key, required this.child});

  final MyTheme currentTheme = GetIt.I<MyTheme>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: Theme.of(context).brightness == Brightness.dark
              ? [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondary,
                ]
              : [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context).colorScheme.secondary,
                ],
        ),
      ),
      child: child,
    );
  }
}

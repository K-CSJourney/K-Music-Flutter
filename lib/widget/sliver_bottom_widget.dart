import 'package:flutter/material.dart';

/// Sliver 底部组件
class SliverBottomWidget extends StatelessWidget {
  const SliverBottomWidget({
    super.key,
    required this.child,
  });

  static button(String text, {VoidCallback? onPressed}) {
    return SliverBottomWidget(
      child: FilledButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  /// 子元素
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

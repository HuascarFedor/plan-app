import 'package:flutter/material.dart';

mixin ScrollToLastItemMixin<T extends StatefulWidget> on State<T> {
  ScrollController get scrollController;
  void scrollToLastItem() {
    if (scrollController.hasClients) {
      final position = scrollController.position.maxScrollExtent;
      scrollController.animateTo(
        position, 
        duration: const Duration(milliseconds: 500), 
        curve: Curves.easeOut,
      );
    }
  }
}

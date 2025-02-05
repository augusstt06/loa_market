import 'package:flutter/material.dart';
import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/widgets/basic/global_appbar.dart';
import 'package:loa_market/widgets/box/item_box.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    super.key,
    required this.items,
    required this.toggleTheme,
    required this.onBack,
  });
  final void Function() toggleTheme;
  final List<Item> items;
  final VoidCallback onBack;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        widget.onBack();
      },
      child: Scaffold(
        appBar: GlobalAppBar(toggleTheme: widget.toggleTheme),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2열로 설정
            childAspectRatio: 1, // 비율 조정
            crossAxisSpacing: 10, // 열 간격
            mainAxisSpacing: 10, // 행 간격
          ),
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return ItemBox(item: widget.items[index]);
          },
        ),
      ),
    );
  }
}

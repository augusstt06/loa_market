import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
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
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Scaffold(
        // FIXME: appbar 삭제하고 대체
        appBar: GlobalAppBar(toggleTheme: widget.toggleTheme),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              CustomText(
                title: '검색 결과',
                fontSize: 'medium',
                isBold: true,
                color: 'black',
              ),
              const Gap(20),
              Expanded(
                  child: ListView.builder(
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ItemBox(item: widget.items[index]),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

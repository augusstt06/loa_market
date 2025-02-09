import 'package:flutter/material.dart';

import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/widgets/basic/appbar/bottom_sheet_appbar.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';

import 'package:loa_market/widgets/box/item_box.dart';

class SearchResultSheet extends StatefulWidget {
  const SearchResultSheet({
    super.key,
    required this.items,
    required this.toggleTheme,
  });
  final void Function() toggleTheme;
  final List<Item> items;

  @override
  State<SearchResultSheet> createState() => _SearchResultSheetState();
}

class _SearchResultSheetState extends State<SearchResultSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BottomSheetAppbar(title: '검색 결과'),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: widget.items.isEmpty
                  ? Center(
                      child: CustomText(
                        title: '검색 결과가 없습니다.',
                        fontSize: 20,
                        isWhite:
                            Theme.of(context).brightness == Brightness.dark,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ItemBox(item: widget.items[index]),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

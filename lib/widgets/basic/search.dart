import 'package:flutter/material.dart';
import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/screens/search_result_screen.dart';
import 'package:loa_market/service/api/post_items.dart';

class Search extends StatefulWidget {
  const Search({super.key, required this.toggleTheme});
  final void Function() toggleTheme;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = '';
  ResponseItemList items = [];

  @override
  void initState() {
    super.initState();
  }

  void navigateToSearchResultScreen(
      BuildContext context, ResponseItemList value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultScreen(
          items: value,
          toggleTheme: widget.toggleTheme,
        ),
      ),
    );
  }

  Future<void> fetchSearchItems(String itemName) async {
    try {
      final ResponseItemList itemResponse = await fetchItems(itemName);

      setState(() {
        items = itemResponse;
      });
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onChanged: (value) {
        searchText = value.trim();
      },
      // onSubmitted: (value) {
      //   navigateToSearchResultScreen(context, value);
      // },
      hintText: '아이템을 입력하세요. (e.g. 숨결)',
      trailing: [
        IconButton(
          onPressed: () async {
            if (searchText.isNotEmpty) {
              //
              await fetchSearchItems(searchText);
              searchText = '';
              navigateToSearchResultScreen(context, items);
            }
          },
          icon: const Icon(Icons.search),
        )
      ],
      overlayColor:
          WidgetStateProperty.all(Theme.of(context).colorScheme.secondary),
      shape: WidgetStateProperty.all(ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      )),
      padding: WidgetStateProperty.all(EdgeInsets.all(6)),
      side: WidgetStateProperty.all(
        BorderSide(color: Theme.of(context).colorScheme.primary, width: 3),
      ),
    );
  }
}

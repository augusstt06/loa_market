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
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
  }

  void navigateToSearchResultScreen(BuildContext context, String value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultScreen(
          searchText: value,
          toggleTheme: widget.toggleTheme,
        ),
      ),
    );
  }

  Future<void> fetchSearchItems(String itemName) async {
    try {
      final List<Item> items = await fetchItems(itemName);
      print(items);
      setState(() {
        this.items = items;
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
          onPressed: () {
            // if (searchText.isNotEmpty) {
            // navigateToSearchResultScreen(context, searchText);
            fetchSearchItems(searchText);

            // }
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

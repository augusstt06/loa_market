import 'package:flutter/material.dart';
import 'package:loa_market/screens/search_result_screen.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    String searchText = '';
    void navigateToSearchResultScreen(BuildContext context, String value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultScreen(searchText: value),
        ),
      );
    }

    return SearchBar(
      onChanged: (value) {
        searchText = value;
      },
      onSubmitted: (value) {
        navigateToSearchResultScreen(context, value);
      },
      hintText: '아이템을 입력하세요. (e.g. 숨결)',
      trailing: [
        IconButton(
          onPressed: () {
            navigateToSearchResultScreen(context, searchText);
          },
          icon: const Icon(Icons.search),
        )
      ],
      overlayColor:
          WidgetStatePropertyAll(Theme.of(context).colorScheme.secondary),
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

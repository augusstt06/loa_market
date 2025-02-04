import 'package:flutter/material.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
import 'package:loa_market/widgets/basic/global_appbar.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    super.key,
    required this.searchText,
    required this.toggleTheme,
  });
  final void Function() toggleTheme;
  final String searchText;

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(toggleTheme: widget.toggleTheme),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomText(title: 'search text', fontSize: 'large'),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: widget.toggleTheme,
      //   backgroundColor: Colors.amber,
      //   child: Icon(
      //       Theme.of(context).brightness == Brightness.dark
      //           ? Icons.sunny
      //           : Icons.nightlight,
      //       color: Colors.white),
      // ),
    );
  }
}

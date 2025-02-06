import 'package:flutter/material.dart';
import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/screens/search_result_screen.dart';
import 'package:loa_market/widgets/basic/global_appbar.dart';
import 'package:loa_market/widgets/box/announce_box.dart';
import 'package:loa_market/widgets/box/crystal_box.dart';
import 'package:loa_market/widgets/box/news_box.dart';
import 'package:loa_market/widgets/basic/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.toggleTheme,
  });

  final void Function() toggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> _searchResult = [];

  void _showSearchResultDialog(List<Item> items) {
    setState(() {
      _searchResult = items;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: SearchResultScreen(
                  items: _searchResult,
                  toggleTheme: widget.toggleTheme,
                  onBack: Navigator.of(context).pop));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(toggleTheme: widget.toggleTheme),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Search(
                toggleTheme: widget.toggleTheme,
                onSearch: _showSearchResultDialog),
          ),
          const AnnounceBox(),
          NewsBox(),
          CrystalBox(),
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

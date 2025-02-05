import 'package:flutter/material.dart';
import 'package:loa_market/models/api_data/post.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
import 'package:loa_market/widgets/basic/global_appbar.dart';

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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomText(title: 'search text', fontSize: 'large'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 100,
                    child: widget.items.isNotEmpty
                        ? Text(widget.items[index].name)
                        : const Text('검색 결과가 없습니다.'),
                  );
                },
              ),
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
      ),
    );
  }
}

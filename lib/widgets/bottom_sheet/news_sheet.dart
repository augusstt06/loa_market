import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loa_market/widgets/basic/appbar/bottom_sheet_appbar.dart';
import 'package:loa_market/widgets/basic/custom_text.dart';
import 'package:loa_market/widgets/basic/progress.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsSheet extends StatefulWidget {
  const NewsSheet({
    super.key,
    required this.newsList,
    required this.isLoading,
  });
  final List<dynamic>? newsList;
  final bool isLoading;

  @override
  State<NewsSheet> createState() => _NewsSheetState();
}

class _NewsSheetState extends State<NewsSheet> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _showScrollToTopButton = _scrollController.offset >= 200;
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _buildNewsList() {
    return ListView.separated(
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.newsList?.length ?? 0,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final news = widget.newsList![index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: InkWell(
            onTap: () {
              if (news.link != null) {
                launchUrl(Uri.parse(news.link));
              }
            },
            child: CustomText(
              title: news.title ?? '제목 없음',
              fontSize: 18,
              isWhite: Theme.of(context).brightness == Brightness.dark,
            ),
          ),
        );
      },
    );
  }

  Widget _buildScrollToTopButton() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        mini: true,
        onPressed: _scrollToTop,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: widget.isLoading
          ? const Center(child: Progress())
          : Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BottomSheetAppbar(title: '로스트아크 소식'),
                    const Gap(15),
                    Expanded(child: _buildNewsList()),
                  ],
                ),
                if (_showScrollToTopButton) _buildScrollToTopButton(),
              ],
            ),
    );
  }
}

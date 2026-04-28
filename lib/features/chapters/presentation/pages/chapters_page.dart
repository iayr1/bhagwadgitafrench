import 'package:flutter/material.dart';

import '../../data/models/chapter_model.dart';
import '../widgets/chapter_card.dart';
import 'chapter_detail_page.dart';

class ChaptersPage extends StatelessWidget {
  const ChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: const Color(0xFF2D1200),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF3D1500), Color(0xFF1A0A00)],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFF6B00).withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFFFD700).withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),

                  /// CENTER CONTENT
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),

                      /// OM (UNCHANGED)
                      const Text(
                        'ॐ',
                        style: TextStyle(
                          fontSize: 40,
                          color: Color(0xFFFFD700),
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// TITLE
                      const Text(
                        'Bhagavad Gita',
                        style: TextStyle(
                          fontSize: 28,
                          color: Color(0xFFFFD700),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// SUBTITLE FIXED
                      Text(
                        'In French • 18 Chapters • 700 Verses',
                        style: TextStyle(
                          fontSize: 13,
                          color: const Color(0xFFFFAA55).withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          /// APPBAR TITLE
          title: const Text(
            'Gita',
            style: TextStyle(
              color: Color(0xFFFFD700),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /// CHAPTER LIST
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final chapter = ChapterModel.chapters[index];
                final color = ChapterModel.chapterColors[
                    index % ChapterModel.chapterColors.length];

                return ChapterCard(
                  chapter: chapter,
                  color: color,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChapterDetailPage(
                          chapterNum: index + 1,
                          chapter: chapter,
                          color: color,
                        ),
                      ),
                    );
                  },
                );
              },
              childCount: ChapterModel.chapters.length,
            ),
          ),
        ),
      ],
    );
  }
}
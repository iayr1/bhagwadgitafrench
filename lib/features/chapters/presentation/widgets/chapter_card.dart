import 'package:flutter/material.dart';

class ChapterCard extends StatelessWidget {
  final Map<String, String> chapter;
  final Color color;
  final VoidCallback onTap;

  const ChapterCard({super.key, required this.chapter, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [color.withOpacity(0.15), const Color(0xFF2D1200)],
              ),
              border: Border.all(color: color.withOpacity(0.3), width: 1),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [color.withOpacity(0.9), color.withOpacity(0.4)]),
                    boxShadow: [BoxShadow(color: color.withOpacity(0.4), blurRadius: 12, spreadRadius: 2)],
                  ),
                  child: Center(child: Text(chapter['num']!, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(chapter['title']!, style: const TextStyle(color: Color(0xFFFFD700), fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 3),
                      Text(chapter['ahirani']!, style: TextStyle(color: color, fontSize: 13, fontStyle: FontStyle.italic)),
                      const SizedBox(height: 4),
                      Text(chapter['summary']!, style: const TextStyle(color: Color(0xFFAA7755), fontSize: 11), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(chapter['verses']!, style: TextStyle(color: color.withOpacity(0.8), fontSize: 11, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Icon(Icons.chevron_right_rounded, color: color.withOpacity(0.7)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

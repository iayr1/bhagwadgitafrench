import 'package:flutter/material.dart';

class VerseCard extends StatelessWidget {
  final Map<String, String> verse;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onPlay;
  final VoidCallback onLike;
  final bool isFavorite;

  const VerseCard({
    super.key,
    required this.verse,
    required this.color,
    required this.onTap,
    required this.onPlay,
    required this.onLike,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFF2D1200),
            border: Border.all(color: color.withOpacity(0.2), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color.withOpacity(0.5)),
                    ),
                    child: Text(
                      'Verse ${verse['num']}',
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onPlay,
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: color,
                      size: 22,
                    ),
                    splashRadius: 20,
                  ),
                  IconButton(
                    onPressed: onLike,
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite
                          ? Colors.redAccent
                          : color.withOpacity(0.7),
                      size: 22,
                    ),
                    splashRadius: 20,
                  ),
                ],
              ),
              const SizedBox(height: 12),

              /// Sanskrit Verse (unchanged)
              Text(
                verse['sanskrit']!,
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 14,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: 10),
              const Divider(color: Color(0xFF3D1500)),
              const SizedBox(height: 8),

              /// French Translation
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D1500),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'French',
                      style: TextStyle(
                        color: Color(0xFFFF9966),
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      verse['French']!,
                      style: const TextStyle(
                        color: Color(0xFFDDC08A),
                        fontSize: 13,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
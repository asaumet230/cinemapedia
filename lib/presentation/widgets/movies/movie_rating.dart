import 'package:flutter/material.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';

class MovieRating extends StatelessWidget {
  final double voteAverage;

  const MovieRating({
    super.key,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      child: Row(
        children: [
          Icon(
            Icons.star_half_outlined,
            color: Colors.yellow.shade800,
          ),
          const SizedBox(width: 3),
          Text(
            HumanFormats.human(voteAverage, 1),
            style: textStyles.bodyMedium?.copyWith(
              color: Colors.yellow.shade800,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

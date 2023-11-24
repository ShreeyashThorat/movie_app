import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';

import '../../utils/color_theme.dart';
import '../../utils/constant_data.dart';
import '../../utils/page_transition.dart';
import '../detailed movie screen/detailed_movie_screen.dart';

class MovieContainer extends StatefulWidget {
  final MovieModel movie;
  const MovieContainer({super.key, required this.movie});

  @override
  State<MovieContainer> createState() => _MovieContainerState();
}

class _MovieContainerState extends State<MovieContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final movie = widget.movie;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: size.height * 0.013,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                SlideTransitionToRight(DetailedMovieScreen(
                  movie: movie,
                )));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                key: UniqueKey(),
                fit: BoxFit.cover,
                width: size.width * 0.27,
                height: size.width * 0.35,
                fadeInDuration: const Duration(milliseconds: 200),
                fadeInCurve: Curves.easeInOut,
                imageUrl: "${ConstantData.posterPath}${movie.posterPath}",
                placeholder: (context, url) => Container(
                  width: size.width * 0.25,
                  height: size.width * 0.35,
                  color: Colors.black.withOpacity(0.15),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              SizedBox(
                width: size.width * 0.025,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  Text(
                    movie.title!,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  Text(
                    movie.overview!,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ],
              ))
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.013,
        ),
        Divider(
          height: 1,
          color: ColorTheme.lightGrey,
        )
      ],
    );
  }
}

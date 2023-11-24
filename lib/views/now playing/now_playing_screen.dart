import 'package:flutter/material.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/utils/color_theme.dart';
import 'package:movie_app/views/widgets/movie_container.dart';

import '../../common widgets/text_field.dart';
import '../../utils/constant_data.dart';

class NowPlayingScreen extends StatefulWidget {
  const NowPlayingScreen({super.key});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  TextEditingController searchController = TextEditingController();
  MovieModel movie = MovieModel.fromJson(ConstantData.movie);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorTheme.primaryColor,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.3),
        automaticallyImplyLeading: false,
        title: MyTextField(
          radius: 10,
          controller: searchController,
          hintText: "Search",
          fillColor: Colors.white,
          filled: true,
          verticalPadding: 10,
          preffix: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search_rounded,
              size: 20,
              color: ColorTheme.hintText,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05, vertical: size.height * 0.015),
        children: [
          ...List.generate(5, (index) => MovieContainer(movie: movie))
        ],
      ),
    );
  }
}

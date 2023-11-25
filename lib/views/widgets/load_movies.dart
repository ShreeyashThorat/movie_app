import 'package:flutter/material.dart';

import '../../common widgets/loading.dart';

class LoadMovies extends StatelessWidget {
  const LoadMovies({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Loading(
            width: size.width * 0.27,
            height: size.width * 0.35,
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
              Loading(
                width: size.width * 0.55,
                height: size.width * 0.045,
                radius: 4,
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Loading(
                width: size.width * 0.45,
                height: size.width * 0.045,
                radius: 4,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              ...List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.only(bottom: size.height * 0.0075),
                  child: Loading(
                    width: size.width * 0.55,
                    height: size.width * 0.035,
                    radius: 1,
                  ),
                );
              })
            ],
          ))
        ],
      ),
    );
  }
}

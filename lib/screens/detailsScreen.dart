// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    print(movie.title);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppbar(title: movie.title, movieimgM: movie.fullBrackDropPath),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(
            title: movie.title,
            movieFondo: movie.fullPosterIMG!,
            tituloOriginal: movie.originalTitle,
            vote: movie.voteCount,
            heroid: movie.heroID,
          ),
          _Overview(movie: movie),
          _Overview(
            movie: movie,
          ),
          _Overview(
            movie: movie,
          ),
          _Overview(
            movie: movie,
          ),
          _Overview(movie: movie),
          CastingCards(movieId: movie.id)
        ]))
      ],
    ));
  }
}

class _CustomAppbar extends StatelessWidget {
  const _CustomAppbar(
      {super.key, required this.title, required this.movieimgM});
  final String title;
  final String movieimgM;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black12,
          child: Text(
            '$title',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(this.movieimgM),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({
    super.key,
    required this.title,
    required this.movieFondo,
    this.tituloOriginal,
    required this.vote,
    this.heroid,
  });

  final String title;
  final String movieFondo;
  final String? tituloOriginal;
  final int vote;
  final String? heroid;

  @override
  Widget build(BuildContext context) {
    final TextTheme texttheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: this.heroid!,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image:
                      NetworkImage(this.movieFondo), //Recibir imagen de fondo
                  height: 150,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  this.title, //Recibir titulo de la pelicula
                  style: texttheme.headlineSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  '$tituloOriginal', // Recibir el titulo Original
                  style: texttheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(children: [
                  Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('$vote', style: texttheme.caption) // RECIBIR MOVIE VOTE
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(movie.overview, style: Theme.of(context).textTheme.subtitle1),
    );
  }
}

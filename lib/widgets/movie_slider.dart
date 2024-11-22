import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';


class MovieSlider extends StatefulWidget {
  
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key, 
    required this.movies,
    required this.onNextPage,
    this.title
  }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(scrollController.position.pixels>=scrollController.position.maxScrollExtent-500){
          widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Column(
        children: [
          if(this.widget.title != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(this.widget.title!),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index)=>_MoviePoster(movie: widget.movies[index])
            )
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;

  const _MoviePoster({Key? key, required this.movie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    movie.heroId = 'swiper-${movie.title}';
    return Container(
                  width: 130,
                  height: 190,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: ()=>Navigator.pushNamed(context, 'details',arguments: movie),
                        child: Hero(
                          tag: movie.heroId!,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: FadeInImage(
                              placeholder: AssetImage('assets/no-image.jpg'), 
                              image: NetworkImage(movie.fullPosterImg),
                              width: 130,
                              height: 190,
                              fit: BoxFit.cover
                            ),
                          ),
                        ),
                      ),
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
  }
}
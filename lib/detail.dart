import 'package:flutter/material.dart';
import 'package:moviestream/model/trending_movie.dart';

class Details extends StatefulWidget {
  final Result result;
  const Details({super.key, required this.result});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final String imgMedium = 'http://image.tmdb.org/t/p/w780';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: buildBody(context, widget.result),
      ),
    );
  }

  ListView buildBody(BuildContext context, Result result) {
    return ListView(
      children: [
        Column(
          children: [
            Stack(
              children: [
                Image.network(
                  "$imgMedium${result.backdropPath}",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 45,
                          width: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Colors.white38),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 45,
                          width: 45,
                          child: FloatingActionButton(
                            heroTag: 'f3',
                            backgroundColor: Colors.white38,
                            // style: ElevatedButton.styleFrom(
                            //     shape: const CircleBorder(),
                            //     backgroundColor: Colors.white38),
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(Icons.more_horiz),
                            ),
                          )),
                    ),
                  ],
                ),
                const Positioned(
                  bottom: 17,
                  left: 30,
                  child: Text(
                    'Preview',
                    style: TextStyle(
                        color: Color.fromARGB(197, 255, 255, 255),
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                      height: 60,
                      child: Center(
                        child: Text(
                          "${result.originalTitle}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                        ),
                      )),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 18),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.cloud_download,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 9),
                  child: Text(
                    '95% match',
                    style: TextStyle(
                        color: Colors.green[400],
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 9, left: 10),
                  child: Text(
                    '2023  2h  49m  R  HD',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 17, top: 6),
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: Color.fromARGB(255, 255, 80, 67),
                      child: Icon(
                        Icons.thumb_up_rounded,
                        size: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 14, top: 6),
                    child: Text(
                      'Most Liked',
                      style: TextStyle(
                          color: Color.fromARGB(201, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17),
              child: SizedBox(
                height: 40,
                width: 350,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Colors.white38,
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.play_arrow),
                        Text('Play'),
                      ],
                    )),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24, top: 25),
                  child: Text(
                    'Prolog',
                    style: TextStyle(
                        color: Color.fromARGB(201, 255, 255, 255),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 10),
                  child: Text(
                    "${result.overview}",
                    style: const TextStyle(
                      color: Colors.white30,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Top Cast',
                    style: TextStyle(
                        color: Color.fromARGB(201, 255, 255, 255),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => TopCastItem(
                        index: index,
                        topcast: Topcastlist[index],
                      ),
                      itemCount: Topcastlist.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TopCastItem extends StatelessWidget {
  final Topcast topcast;
  final int index;
  const TopCastItem({
    super.key,
    required this.topcast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 100,
      // color: Colors.white30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('${topcast.image}'),
            radius: 27,
          ),
          Text(
            '${topcast.name}',
            style: const TextStyle(
              color: Color.fromARGB(201, 255, 255, 255),
              fontSize: 14,
            ),
          ),
          Text(
            '${topcast.charactor}',
            style: const TextStyle(
              color: Color.fromARGB(201, 255, 255, 255),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class Topcast {
  final String? image, name, charactor;

  Topcast({
    this.image,
    this.name,
    this.charactor,
  });
}

// ignore: non_constant_identifier_names
List Topcastlist = [
  Topcast(
    image: "lib/image/casts/keanuReeves.jpg",
    name: "Keanu Reaves",
    charactor: 'John Wick',
  ),
  Topcast(
    image: 'lib/image/casts/donnieYen.jpg',
    charactor: 'Caine',
    name: 'DonnieYen',
  ),
  Topcast(
    image: 'lib/image/casts/billKarsgard.jpeg',
    charactor: 'Marquice vincent',
    name: 'Bill Karsgard',
  ),
  Topcast(
    image: 'lib/image/casts/LanceReddick.jpeg',
    charactor: 'Charon',
    name: 'lance Reddick',
  ),
  Topcast(
    image: 'lib/image/casts/scottAdkins.jpg',
    charactor: 'Killa',
    name: 'Scott Adlins',
  ),
];

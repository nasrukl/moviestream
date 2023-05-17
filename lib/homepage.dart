import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:moviestream/detail.dart';
import 'package:moviestream/services/api_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final List<String> trendingImageList = [
  //   'lib/image/kgf.jpg',
  //   'lib/image/Echoes-Poster.jpg',
  //   'lib/image/oxygen.jpg',
  //   'lib/image/vikram.jpg',
  //   'lib/image/1899.jpg',
  // ];

  // ignore: non_constant_identifier_namesimport '../model/top_rated.dart';

  // final List<String> SeriesImagelist = [
  //   'lib/image/wednesday.jpg',
  //   'lib/image/dark.jpeg',
  //   'lib/image/stranger.jpg',
  //   'lib/image/moneyheast.jpg',
  // ];

  // ignore: non_constant_identifier_names
  // final List<String> KoreanImagelist = [
  //   'lib/image/kor1.jpeg',
  //   'lib/image/kor2.jpeg',
  //   'lib/image/kor3.jpeg',
  //   'lib/image/kor4.jpeg',
  //   'lib/image/kor5.png',
  // ];
  final ApiServices apiServices = ApiServices();
  final String imgMedium = "http://image.tmdb.org/t/p/w780";
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: Future.wait([
          apiServices.getTrendingMovies(),
          apiServices.getPopularSeries(),
          apiServices.getTopRated(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // if (snapshot.data![0] != null && snapshot.data![1] != null) {
            var myData = snapshot.data![0]!;
            var myData2 = snapshot.data![1]!;
            var myData3 = snapshot.data![2]!;

            return NestedScrollView(
              headerSliverBuilder: (_, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    pinned: true,
                    toolbarHeight: kToolbarHeight + 20,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: FloatingActionButton(
                              tooltip: 'f1',
                              onPressed: () {},
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: Image.asset('lib/image/profile.jpeg'),
                              )),
                        ),
                        SizedBox(
                          height: 45,
                          width: 45,
                          child: FloatingActionButton(
                            heroTag: 'f2',
                            backgroundColor: Colors.white38,
                            onPressed: () {},
                            child: const Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                    expandedHeight: MediaQuery.of(context).size.height * .6,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        fit: StackFit.expand,
                        children: [
                          CarouselSlider.builder(
                              unlimitedMode: true,
                              itemCount: myData.results.length,
                              slideTransform: const TabletTransform(),
                              enableAutoSlider: true,
                              // onSlideChanged: (value) {
                              //   // setState(() {
                              //   //   currentIndex = value;
                              //   // });
                              //   print(value);
                              // },
                              slideBuilder: (index) {
                                return ShaderMask(
                                  shaderCallback: (bounds) {
                                    currentIndex = index;
                                    return const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: [0.5, 1],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black,
                                      ],
                                    ).createShader(bounds);
                                  },
                                  blendMode: BlendMode.srcATop,
                                  child: Image.network(
                                    imgMedium +
                                        myData.results[index].posterPath!,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }),
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 35,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18))),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color.fromARGB(
                                                      154, 158, 158, 158))),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.play_arrow),
                                          Text('Play'),
                                        ],
                                      ),
                                    )),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  height: 35,
                                  width: 100,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => Details(
                                          result: myData.results[currentIndex],
                                        ),
                                      ));
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => Details(),
                                      //     ),
                                      //     (route) => false);
                                    },
                                    style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          width: 1.5,
                                          color: Colors.white,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18))),
                                    child: const Text(
                                      'Details',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, left: 20),
                              child: Text(
                                'Trending Now',
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    color: Colors.white30,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            itemCount: myData.results.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.teal,
                                  image: DecorationImage(
                                    image: NetworkImage(imgMedium +
                                        myData.results[index].posterPath!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 10);
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, left: 20),
                              child: Text(
                                'Series',
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    color: Colors.white30,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            itemCount: myData2.results.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.teal,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imgMedium +
                                          myData2.results[index].posterPath!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 10);
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20, bottom: 20, left: 20),
                              child: Text(
                                'Top Rated',
                                style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    color: Colors.white30,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            itemCount: myData3.results.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.teal,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      imgMedium +
                                          myData3.results[index].posterPath!,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 10);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // } else {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }
        },
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black.withOpacity(.5),
        items: const [
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.recommend,
                  color: Colors.white54,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.cloud_download,
                  color: Colors.white54,
                ),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Icon(
                  Icons.movie,
                  color: Colors.white54,
                ),
              ),
              label: ''),
        ],
      ),
    );
  }
}

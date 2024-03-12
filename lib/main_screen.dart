import 'package:flutter/material.dart';
import 'package:wisatajogja/detail_screen.dart';
import 'package:wisatajogja/model/tourism_place.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Apps'),
        backgroundColor: const Color.fromARGB(255, 198, 209, 226),
        actions: [
          IconButton(
            icon: const Icon(Icons.search,
                color: Color.fromARGB(255, 19, 18, 18)),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Color.fromARGB(255, 20, 20, 20)),
          onPressed: () {},
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final TourismPlace place = tourismPlaceList[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailScreen(
                  place: place,
                );
              }));
            },
            child: Card(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Image.asset(place.imageAsset),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(place.name,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            Text(place.location),
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          );
        },
        itemCount: tourismPlaceList.length,
      ),
    );
  }
}

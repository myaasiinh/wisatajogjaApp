import 'package:flutter/material.dart';
import 'package:wisatajogja/screen/detail_screen.dart';
import 'package:wisatajogja/model/tourism_place.dart';
import 'package:wisatajogja/screen/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<TourismPlace> filteredPlaces;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    filteredPlaces = tourismPlaceList;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisata Bandung'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserInfoContainer(),
          Expanded(child: _buildTourismPlaceList()),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
            onChanged: _onSearchTextChanged,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserInfoContainer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.green,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/farm-house.jpg'),
            radius: 30,
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alfian',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'alfianganteng@gmail.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTourismPlaceList() {
    return ListView.separated(
      itemCount: filteredPlaces.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (context, index) {
        final place = filteredPlaces[index];
        return InkWell(
          onTap: () => _navigateToDetailScreen(place),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: ListTile(
              leading: Image.asset(
                place.imageAsset,
                width: 100,
                fit: BoxFit.cover,
              ),
              title: Text(place.name),
              subtitle: Text(place.location),
            ),
          ),
        );
      },
    );
  }

  void _onSearchTextChanged(String value) {
    setState(() {
      filteredPlaces = tourismPlaceList
          .where((place) => place.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void _navigateToDetailScreen(TourismPlace place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(place: place),
      ),
    );
  }
}

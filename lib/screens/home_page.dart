import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/models/model.dart';
import 'package:restaurant_app/screens/detail_page.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App',
            style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Resto Favoritmu',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              onChanged: (text) {
                print('Search query: $text');
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString('assets/local_restaurant.json'),
              builder: (context, snapshot) {
                final List<Restaurant> restaurants =
                    parseRestaurants(snapshot.data);

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    return _RestaurantList(context, restaurant);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _RestaurantList(BuildContext context, Restaurant restaurant) {
  void navigateToDetailPage(BuildContext context, Restaurant restaurant) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RestaurantDetailPage(restaurant: restaurant),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 5, top: 5),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 2, color: Colors.black12),
        borderRadius: BorderRadius.circular(20),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          restaurant.pictureId!,
          fit: BoxFit.cover,
          width: 100,
        ),
      ),
      title: Text(restaurant.name!),
      subtitle: Row(
        children: [
          const Icon(
            Icons.location_pin,
            size: 18,
            color: Colors.red,
          ),
          const SizedBox(width: 4),
          Text(
            '${restaurant.city}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: const Color(0xFF616161)),
          ),
        ],
      ),
      onTap: () {
        navigateToDetailPage(context, restaurant);
      },
    ),
  );
}

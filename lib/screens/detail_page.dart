import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/models/model.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = "/restaurant_detail";

  final Restaurant restaurant;

  const RestaurantDetailPage({super.key, required this.restaurant});

  Widget _buildRestaurantInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    '${restaurant.city}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.merge(TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            RatingBar.builder(
              initialRating: restaurant.rating ?? 0.0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.yellow[600],
              ),
              onRatingUpdate: (rating) {},
            ),
          ],
        ),
        Divider(
          color: Colors.green[200],
          thickness: 1,
        ),
        Text(
          restaurant.description!,
          textAlign: TextAlign.justify,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.merge(TextStyle(color: Colors.white)),
        )
      ]),
    );
  }

  Widget _buildRestaurantMenu(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _buildBeverageList(context, "Foods  ", restaurant.menus!.foods),
        Divider(
          thickness: 1,
          color: Colors.green[200],
        ),
        _buildBeverageList(context, "Drinks  ", restaurant.menus!.drinks),
      ]),
    );
  }

  Widget _buildBeverageList(
      BuildContext context, String title, List<Beverage> beverages) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.merge(TextStyle(color: Colors.white)),
      ),
      const SizedBox(
        height: 8,
      ),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: List.generate(beverages.length,
            (index) => _buildBeverageItem(context, beverages[index])),
      )
    ]);
  }

  Widget _buildBeverageItem(BuildContext context, Beverage beverage) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.green[400],
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        beverage.name,
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.merge(TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: restaurant.pictureId!,
                  child: Stack(children: [
                    Positioned.fill(
                      child: Image.network(
                        restaurant.pictureId!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.white.withOpacity(0.5),
                    )
                  ]),
                ),
                title: Text(
                  restaurant.name!,
                  style: GoogleFonts.robotoSlab(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
                titlePadding: const EdgeInsets.only(left: 45, bottom: 16),
              ),
            ),
          ];
        }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                _buildRestaurantInfo(context),
                const SizedBox(
                  height: 16,
                ),
                _buildRestaurantMenu(context)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

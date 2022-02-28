import 'package:flutter/material.dart';

// LOCAL PACKAGES
import 'package:game_street/components/footer.dart';
import 'package:game_street/components/navbar.dart';
import 'package:game_street/components/sidebar.dart';
import 'package:game_street/components/carousel.dart';
import 'package:game_street/components/searchbar.dart';
import 'package:game_street/components/homeSlider.dart';
import 'package:game_street/components/HomeGridItem.dart';

class Home extends StatelessWidget {
  // BANNER IMAGES
  final List<String> bannerImages = [
    'assets/Header_Banner-GoW.jpg',
    'assets/Header_Banner-Ratchet.jpg',
    'assets/Header_Banner-Xbox_Series_S.jpg',
  ];
  
  // TRENDING IMAGES
  final List trendingGames = [
    {'id': '610899ab7be4872050e609fc', 'url': 'assets/images/products/box_art/Demons_Souls-PS5.jpg'},
    {
      'id': '610899ab7be4872050e60a03',
      'url': 'assets/images/products/box_art/Flight_Simulator-Xbox_Series_X.jpg'
    },
    {
      'id': '610899ab7be4872050e609fa',
      'url': 'assets/images/products/box_art/God_of_War-PS4.jpg'
    },
    {
      'id': '612ec67751895f450c4f8a3e',
      'url': 'assets/images/products/box_art/Ratchet_&_Clank-PS5.jpg'
    },
    {
      'id': '610899ab7be4872050e609fe',
      'url': 'assets/images/products/box_art/Red_Dead_Redemption_2-PS4.jpg'
    },
    {
      'id': '610899ab7be4872050e60a0b',
      'url': 'assets/images/products/box_art/Super_Mario_Odyssey-Switch.jpg'
    },
    {
      'id': '610899ab7be4872050e609fb',
      'url': 'assets/images/products/box_art/The_Last_of_Us_Part_II-PS5.jpg'
    },
    {
      'id': '610899ab7be4872050e60a0a',
      'url':
          'assets/images/products/box_art/The_Legend_of_Zelda-Breath_of_the_Wild-Switch.jpg'
    },
    {
      'id': '6121b9142b8da63678acb9df',
      'url': 'assets/images/products/box_art/Uncharted_4_-A_Thiefs_End-PS4.jpg'
    },
    {
      'id': '610899ab7be4872050e609fd',
      'url': 'assets/images/products/box_art/witcher_3-goty-PS4.jpg'
    },
  ];

// UPCOMING IMAGES
  final List upcomingGames = [
    {
      'id': '6121b881fb1d81202c1cb212',
      'url':
          'assets/images/products/box_art/Dying_Light_2-Deluxe_Edition-PS4.jpg'
    },
    {
      'id': '6121b6ccdce536120423bb49',
      'url': 'assets/images/products/box_art/FIFA_22-PS5.jpg'
    },
    {
      'id': '6121b8878334f437d07b20b1',
      'url': 'assets/images/products/box_art/Forza_Horizon_5-Xbox_Series_X.jpg'
    },
    {
      'id': '6121b8ca0df85739e87895ed',
      'url': 'assets/images/products/box_art/Madden_NFL_22-PS5.jpg'
    },
    {
      'id': '6121b88cb0d1412c6c5d988a',
      'url': 'assets/images/products/box_art/Mario_Golf-Super_Rush-Switch.jpg'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff151515),
      appBar: AppBar(
        elevation: 3,
        toolbarHeight: 85,
        backgroundColor: Color(0xff151515),
        automaticallyImplyLeading: false,
        title: Navbar(),
      ),
      drawer: Sidebar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SEARCHBAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Searchbar(),
                ),
                SizedBox(height: 30),
                // BANNER
                HomeSlider(bannerImages),
                SizedBox(
                  height: 35.0,
                ),
                // TRENDING
                Center(
                  child: Text(
                    "TRENDING",
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontFamily: 'FiraSans-Medium',
                        letterSpacing: 1.0,
                        fontSize: 26.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Carousel(trendingGames),
                ),
                SizedBox(
                  height: 60.0,
                ),
                
                //  PRODUCTS GRID
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 630,
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 50.0,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          HomeGridItem(
                            gridTitle: 'Playstation 5',
                            gridImage: 'assets/images/products/consoles/PS5-PS5_Console.jpg',
                            backendCategory: 'consoles',
                            backendPlatform: 'PS5',
                          ),
                          HomeGridItem(
                            gridTitle: 'Playstation 4',
                            gridImage:
                                'assets/images/products/consoles/PS4-PS4_Pro_1TB_Console_with_Death_Stranding.jpg',
                            backendCategory: 'consoles',
                            backendPlatform: 'PS4',
                          ),
                          HomeGridItem(
                            gridTitle: 'Xbox Series X|S',
                            gridImage:
                                'assets/images/products/consoles/Series_X&S-Xbox_Series_S_Console.jpg',
                            backendCategory: 'consoles',
                            backendPlatform: 'Xbox Series X|S',
                          ),
                          HomeGridItem(
                            gridTitle: 'Nintendo Switch',
                            gridImage: 'assets/images/products/consoles/Switch-Black.jpg',
                            backendCategory: 'consoles',
                            backendPlatform: 'Nintendo Switch',
                          ),
                          HomeGridItem(
                            gridTitle: 'Video Games',
                            gridImage:
                                'assets/images/products/box_art/PS5-Miles_Morales-Ultimate_Edition.jpg',
                            backendCategory: 'games',
                          ),
                          HomeGridItem(
                            gridTitle: 'Accessories',
                            gridImage:
                                'assets/images/products/accessories/Series_X&S-Microsoft_Xbox_Series_X_Robot_White_Wireless_Controller.jpg',
                            backendCategory: 'accessories',
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
                // COMING SOON
                Center(
                  child: Text(
                    "COMING SOON",
                    style: TextStyle(
                        color: Colors.amberAccent,
                        fontFamily: 'FiraSans-Medium',
                        letterSpacing: 1.0,
                        fontSize: 26.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Carousel(upcomingGames),
                ),
              
              // FOOTER component
              Footer(marginTop: 50.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

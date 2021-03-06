import 'package:flighttickets/CustomAppBar.dart';
import 'package:flighttickets/CustomShapeClipper.dart';
import 'package:flighttickets/flight_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(
      MaterialApp(
        title: 'Flight List Mock Up',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        theme: appTheme,
      ),
    );

var firstColor = Color(0xFFF47D15);
var secondColor = Color(0xFFEF772C);
var clipLinearGradient = LinearGradient(colors: [firstColor, secondColor]);



var appTheme = ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

var locations = ['Boston (BOS)', 'New York City (JFK)'];

final textEditingController = TextEditingController(text: locations[1]);

const dropDownLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const dropDownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16.0);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeScreenTopPart(),
            homeScreenBottomPart,
            homeScreenBottomPart
          ],
        ),
      ),
    );
  }
}

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationIndex = 0;
  var isFlightSelected = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400.0,
            decoration: BoxDecoration(
                gradient: clipLinearGradient),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      PopupMenuButton(
                        onSelected: (index) {
                          setState(() {
                            selectedLocationIndex = index;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              locations[selectedLocationIndex],
                              style: dropDownLabelStyle,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            )
                          ],
                        ),
                        itemBuilder: (buildContext) => <PopupMenuItem<int>>[
                              PopupMenuItem(
                                child: Text(locations[0],
                                    style: dropDownMenuItemStyle),
                                value: 0,
                              ),
                              PopupMenuItem(
                                child: Text(locations[1],
                                    style: dropDownMenuItemStyle),
                                value: 1,
                              )
                            ],
                      ),
                      Spacer(),
                      Icon(Icons.settings, color: Colors.white)
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Where would\nyou want to go?',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    child: TextField(
                      controller: textEditingController,
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 14.0),
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => InheritedFlightListing(
                                    fromLocation: locations[selectedLocationIndex],
                                    toLocation: textEditingController.text,
                                    child: FlightListing(),
                                  )
                                ));
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                          )),
                      style: dropDownMenuItemStyle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          setState(() {
                            isFlightSelected = true;
                          });
                        },
                        child: ChoiceChip(
                            Icons.flight_takeoff, 'Flights', isFlightSelected)),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            isFlightSelected = false;
                          });
                        },
                        child: ChoiceChip(
                            Icons.hotel, 'Hotels', !isFlightSelected))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isFlightSelected;

  ChoiceChip(this.icon, this.text, this.isFlightSelected);

  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.isFlightSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.all(Radius.circular(20.0)))
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20.0,
            color: Colors.white,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(widget.text,
              style: TextStyle(fontSize: 14.0, color: Colors.white))
        ],
      ),
    );
  }
}

var viewAllStyle = TextStyle(color: appTheme.primaryColor, fontSize: 14.0);

var homeScreenBottomPart = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('Currently watched items', style: dropDownMenuItemStyle),
          Spacer(),
          Text(
            'VIEW ALL(12)',
            style: viewAllStyle,
          )
        ],
      ),
    ),
    Container(
      height: 210,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cityCards,
      ),
    )
  ],
);

var cityCards = [
  CityCard(
      'assets/images/lasvegas.jpg', 'Las Vegas', 'Feb 2019', '45', 4299, 2250),
  CityCard('assets/images/athens.jpg', 'Athens', 'Apr 2019', '50', 9999, 4159),
  CityCard('assets/images/sydney.jpeg', 'Sydney', 'Dec 2018', '40', 5999, 2399)
];

final formatCurrency = new NumberFormat.simpleCurrency();

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount;
  final int oldPrice, newPrice;
  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount,
      this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 180.0,
                  width: 160.0,
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  width: 160.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.1)
                        ])),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              cityName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white),
                            ),
                            Text(
                              monthYear,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: Colors.white),
                            )
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 2.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Text(
                              "$discount%",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14.0),
                            ))
                      ]),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              Text("${formatCurrency.format(newPrice)}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0)),
              SizedBox(
                width: 5.0,
              ),
              Text("(${formatCurrency.format(oldPrice)})",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 14.0))
            ],
          )
        ],
      ),
    );
  }
}

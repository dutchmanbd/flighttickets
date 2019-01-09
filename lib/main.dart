import 'package:flighttickets/CustomShapeClipper.dart';
import 'package:flutter/material.dart';

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

var appTheme = ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

var locations = ['Boston (BOS)', 'New York City (JFK)'];

const dropDownLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const dropDownMenuItemStyle = TextStyle(color: Colors.black, fontSize: 16.0);

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          HomeScreenTopPart(),
          homeScreenBottomPart,
        ],
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
                gradient: LinearGradient(colors: [firstColor, secondColor])),
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
                      controller: TextEditingController(text: locations[1]),
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 14.0),
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
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
                      child: ChoiceChip(Icons.hotel, 'Hotels', !isFlightSelected)
                    )
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
          Text('VIEW ALL(12)', style: viewAllStyle,)
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
  // CityCard('assets/images/lasvegas.jpg', 'Las Vegas', 'Feb 2019', '45', '4299', '2250'),
  CityCard('assets/images/athens.jpg', 'Athens', 'Apr 2019', '50', '9999', '4159'),
  CityCard('assets/images/sydney.jpeg', 'Sydney', 'Dec 2018', '40', '5999', '2399')
];

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount, oldPrice, newPrice;
  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount, this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 210.0,
          width: 160.0,
          child: Image.asset(imagePath, fit: BoxFit.cover),
        )
      ],
    );
  }
}
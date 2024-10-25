import 'dart:math';
import 'package:location/location.dart';
import 'consts.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'accountpage.dart';
import 'homepage.dart';

class TrackPage extends StatefulWidget {
  @override
  _TrackPageState createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  int _selectedIndex = 0;

  // Static coordinates for map integration
  static const LatLng dst = LatLng(13.349076828086552, 74.78514321559913);
  static const LatLng src = LatLng(13.359332985171177, 74.7851281422341);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  LatLng busLocation = src; // Start the bus at the source

  Timer? _timer;

  // Notification variables
  String? notificationMessage;
  String? notificationTime;

  // Use custom icons for markers
  BitmapDescriptor? busIcon;
  BitmapDescriptor? homeIcon;
  BitmapDescriptor? schoolIcon;

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      setState(() {
        currentLocation = location;
      });
    }).catchError((e) {
      print("Error getting location: $e");
    });
  }

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  // Method to fetch polyline points for the route
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY, // Ensure this API key is valid
      PointLatLng(src.latitude, src.longitude),
      PointLatLng(dst.latitude, dst.longitude),
    );

    if (result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });

      startBusMovement(); // Start moving the bus only after we have the polyline
    } else {
      print("No points found for the route.");
    }
  }

  void setCustomMarkers() async {
    homeIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/home_icon.png',
    );
    schoolIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/school_icon.png',
    );
    busIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)),
      'assets/images/bus_icon.png',
    );
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    getPolyPoints();
    setCustomMarkers();
    startBusMovement(); // Start moving the bus
  }

  // Function to show notifications
  void showNotification(String message) {
    setState(() {
      notificationMessage = message;
      notificationTime =
          TimeOfDay.now().format(context); // Get the current time
    });

    // Automatically hide the notification after 5 seconds
    // Future.delayed(Duration(seconds: 5), () {
    //   setState(() {
    //     notificationMessage = null;
    //     notificationTime = null;
    //   });
    // });
  }

  // Function to move the bus along the polyline points
  void startBusMovement() {
    if (polylineCoordinates.isEmpty) return;

    int currentIndex = 0;
    bool hasLeftHome = false; // Track if the bus has left the home
    bool hasReachedSchool = false; // Track if the bus has reached the school

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (currentIndex < polylineCoordinates.length - 1) {
        setState(() {
          busLocation = polylineCoordinates[currentIndex];
          currentIndex++;

          // Check if the bus has left the source (home)
          if (!hasLeftHome && currentIndex > 0) {
            hasLeftHome = true;
            showNotification("The bus has left your location");
          }

          // Check if the bus has reached the destination (school)
          if (!hasReachedSchool &&
              currentIndex == polylineCoordinates.length - 1) {
            hasReachedSchool = true;
            showNotification("The bus has reached the school");
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Define the icons for the bottom navigation
  IconData _leftIcon = Icons.home;
  IconData _rightIcon = Icons.person;
  IconData _centerIcon = Icons.location_pin;

  // Method to handle bottom navigation
  void _onItemTapped(String position) {
    setState(() {
      if (position == 'left') {
        IconData temp = _centerIcon;
        _centerIcon = _leftIcon;
        _leftIcon = temp;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (position == 'right') {
        IconData temp = _centerIcon;
        _centerIcon = _rightIcon;
        _rightIcon = temp;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackPage()),
        );
      }
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent.shade200,
        title: Text(
          "Track Your Bus",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.yellow.shade700,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left button
                  IconButton(
                    icon: Icon(_leftIcon, size: 30, color: Colors.white),
                    onPressed: () {
                      _onItemTapped('left');
                    },
                  ),
                  const SizedBox(width: 30),
                  // Right button
                  IconButton(
                    icon: Icon(_rightIcon, size: 30, color: Colors.white),
                    onPressed: () {
                      _onItemTapped('right');
                    },
                  ),
                ],
              ),
            ),
          ),
          // Elevated center button
          Positioned(
            top: -30,
            left: MediaQuery
                .of(context)
                .size
                .width / 2 - 35,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange.shade400,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  _centerIcon,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  _onItemTapped('center');
                },
              ),
            ),
          ),
        ],
      ),
      body: currentLocation == null
          ? Center(
        child: CircularProgressIndicator(),
      ) // Show a loader until location is retrieved
          : Column(
        children: [
          // Google Map Section
          Container(
            height: 400, // Limit the height of the map
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    src.latitude, src.longitude),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId("route"),
                  points: polylineCoordinates,
                  color: Colors.blue,
                  width: 5,
                ),
              },
              markers: {
                Marker(
                  markerId: MarkerId("bus"),
                  position: busLocation,
                  icon: busIcon!, // Use custom bus icon
                ),
                Marker(
                  markerId: MarkerId("home"),
                  position: src,
                  icon: homeIcon!, // Use custom home icon
                ),
                Marker(
                  markerId: MarkerId("school"),
                  position: dst,
                  icon: schoolIcon!, // Use custom school icon
                ),
              },
            ),
          ),

          // Notification Bar
          if (notificationMessage != null)
            Container(

              padding: EdgeInsets.all(16),
              color: Colors.orange.shade400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notificationMessage!,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    notificationTime ?? "",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

          // Scrollable Information Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  width: 500,
                  padding: const EdgeInsets.all(17.0),
                  decoration: BoxDecoration(

                    image: const DecorationImage(image:AssetImage("assets/images/vg.png"),fit: BoxFit.fill),

                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Driver: Ahmed Shah',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Conductor: Sachi Parsekar',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Bus Number: KA 19 AB 1234',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Boarding Time: '+TimeOfDay.now().format(context) ,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Status: In Transit',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Contact: +91 9876543210',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:RunningApp/component/MapScreenBlocks/timer.dart';
import 'package:RunningApp/component/iconText.dart';
import 'package:RunningApp/component/loadingButton.dart';
import 'package:RunningApp/component/popup.dart';
import 'package:RunningApp/helper/calculateDistance.dart';
import 'package:RunningApp/repository/AppData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _controller;
  static double zoom = 14.4746;
  static double bearing = 0;
  static bool shouldMoveCamera = true;
  static double distance = 0;
  static int startTime = 0;
  static String currSpeed = '0';
  static int rating = 0;
  bool isRunning = false;
  List<LocationData> locationHistory = [];
  StreamSubscription<LocationData> _locationSubscription;

  Location location;
  LocationData currentLocation;
  Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();

    location = new Location();
  }

  _handleLocationChange(LocationData currentLocation) {
    _updateDistance(currentLocation);
    _updateTrail(currentLocation);
    setState(() {
      currSpeed = currentLocation.speed.toStringAsFixed(2);
      locationHistory.add(currentLocation);
    });

    if (_controller != null) {
      updateCameraPosition(currentLocation);
    }
  }

  updateCameraPosition(LocationData currentLocation) {
    if (!shouldMoveCamera) {
      return;
    }

    _controller
        .animateCamera(
          CameraUpdate.newCameraPosition(
            new CameraPosition(
              bearing: bearing,
              target:
                  LatLng(currentLocation.latitude, currentLocation.longitude),
              tilt: 0,
              zoom: zoom,
            ),
          ),
        )
        .then((value) => shouldMoveCamera = true);
  }

  _onMapCreated(GoogleMapController mapController) {
    setState(() {
      _controller = mapController;
    });

    setInitialLocation();
  }

  setInitialLocation() async {
    currentLocation = await location.getLocation();

    if (_controller != null) {
      _controller.moveCamera(
        CameraUpdate.newCameraPosition(
          new CameraPosition(
            bearing: bearing,
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            tilt: 0,
            zoom: zoom,
          ),
        ),
      );
    }
  }

  _handleRunEnd() async {
    showPopup(
      context,
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
              child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Run finished!'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //TODO: Replace distance with real calculated values
                    IconText(
                        Image(
                          image: AssetImage('img/coinImage.png'),
                          width: 24,
                          height: 24,
                        ),
                        distance.round().toString()),
                    IconText(
                        Icon(
                          Icons.star,
                          color: Colors.blue[800],
                        ),
                        distance.round().toString()),
                  ],
                ),
                RatingBar(
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  ratingWidget: RatingWidget(
                    empty: Icon(
                      Icons.star_border,
                      color: Colors.amber,
                    ),
                    half: Icon(
                      Icons.star_half,
                      color: Colors.amber,
                    ),
                    full: Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  onRatingUpdate: _setRating,
                ),
                LoadingButton(
                  onPressed: () async {
                    if (_locationSubscription != null) {
                      _locationSubscription.cancel();
                    }
                    await _saveRun();
                    _clearRunData();
                    Navigator.of(context).pop();
                  },
                  child: Text("End"),
                ),
              ],
            ),
          ),
        ),
      ),
      showCloseButton: false,
      height: 300.0,
    );
  }

  _setRating(double newRating) {
    setState(() {
      rating = newRating.round();
    });
  }

  _handleRunStart() {
    _getLocation();
  }

  _clearRunData() {
    setState(() {
      rating = null;
      locationHistory = [];
      _polyline = {};
      isRunning = false;
    });
  }

  _getLocation() async {
    LocationData position = await location.getLocation();

    List<LatLng> points = List();
    points.add(LatLng(position.latitude, position.longitude));

    _polyline.add(Polyline(
      polylineId: PolylineId('trail'),
      visible: true,
      points: points,
      width: 2,
      color: Colors.blue,
    ));

    setState(() {
      distance = 0;
      isRunning = true;
      currSpeed = position.speed.toStringAsFixed(2);
      startTime = position.time.toInt();
      locationHistory.add(position);
      _locationSubscription =
          location.onLocationChanged.listen(_handleLocationChange);
    });
  }

  _goToMainScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/',
      (Route<dynamic> route) => false,
    );
  }

  _saveRun() async {
    final appData = AppData(context);
    if (locationHistory.isNotEmpty) {
      await appData.addRun({
        "locations": locationHistory,
        "distance": distance.toInt(),
        "time": locationHistory.last.time.toInt() -
            locationHistory.first.time.toInt(),
        "rating": rating
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !isRunning ? _getAppBar() : null,
      body: getMap(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        label: isRunning ? Text('End') : Text('Start run'),
        onPressed: isRunning ? _handleRunEnd : _handleRunStart,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: isRunning
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('${distance.toStringAsFixed(2)}m'),
                Text('${currSpeed}m/s'),
                TimeLeft(startTime: startTime),
                SizedBox(
                  height: 50,
                ),
              ],
            )
          : null,
    );
  }

  Widget _getAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => _goToMainScreen()),
    );
  }

  Widget getMap() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: LatLng(0, 0), zoom: 12),
      onMapCreated: _onMapCreated,
      mapToolbarEnabled: true,
      myLocationButtonEnabled:
          true, //Might need to replace with own button to keep animation
      myLocationEnabled: true,
      padding: EdgeInsets.all(10),
      polylines: isRunning ? _polyline : null,
    );
  }

  _updateDistance(LocationData currentLocation) {
    double initialLat = locationHistory.last.latitude;
    double initialLon = locationHistory.last.longitude;
    double finalLat = currentLocation.latitude;
    double finalLon = currentLocation.longitude;

    double newDistance =
        calculationByDistance(initialLat, initialLon, finalLat, finalLon);

    setState(() {
      distance += newDistance;
    });
  }

  _updateTrail(LocationData currentLocation) {
    setState(() {
      _polyline.first.points
          .add(LatLng(currentLocation.latitude, currentLocation.longitude));
    });
  }
}

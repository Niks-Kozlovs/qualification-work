import 'package:RunningApp/component/iconText.dart';
import 'package:RunningApp/model/Run/Run.dart';
import 'package:RunningApp/model/Run/RunData.dart';
import 'package:RunningApp/repository/AppData.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../timeDisplay.dart';

class RunHistoryBlock extends StatelessWidget {
  const RunHistoryBlock({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppData(context);
    final runs = user.userData.runs;

    String getRanFor(List<RunData> locationData) {
      return getTimeString(locationData.first.time, locationData.last.time);
    }

    if (runs.isEmpty) {
      return Center(
        child: Text("No runs"),
      );
    }

    final format = DateFormat('dd-MM-yyyy');

    return ListView(
      children: runs
          .map<Widget>(
            (Run run) => Row(
              children: [
                Column(
                  children: [
                    Text(format.format(DateTime.fromMillisecondsSinceEpoch(
                        run.locationData.first.time))),
                    Text('Ran for ${getRanFor(run.locationData)}'),
                    Text(run.rating == null
                        ? 'Not set'
                        : 'Rating: ${run.rating.toString()}'),
                    IconText(
                        Image(
                          image: AssetImage('img/coinImage.png'),
                          width: 24,
                          height: 24,
                        ),
                        run.coins.toString()),
                    IconText(
                      Icon(
                        Icons.star,
                        color: Colors.blue[800],
                      ),
                      run.experience.toString(),
                    ),
                  ],
                ),
                Container(
                  child: RunPreview(run.locationData),
                  margin: EdgeInsets.all(8),
                  width: 200,
                  height: 200,
                )
              ],
            ),
          )
          .toList(),
    );
  }
}

class RunPreview extends StatelessWidget {
  final List<RunData> run;
  final Set<Polyline> _polyline = {};
  RunPreview(this.run) {
    _polyline.add(Polyline(
        polylineId: PolylineId("route"),
        visible: true,
        width: 3,
        endCap: Cap.roundCap,
        startCap: Cap.roundCap,
        color: Colors.blue,
        points:
            run.map<LatLng>((e) => LatLng(e.latitude, e.longtitude)).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: getCenterCoordinates(),
      polylines: _polyline,
      onMapCreated: _onMapCreated,
      myLocationEnabled: false,
      zoomGesturesEnabled: false,
      minMaxZoomPreference: MinMaxZoomPreference(1, 16),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.moveCamera(
        CameraUpdate.newLatLngBounds(boundsFromLatLngList(this.run), 8));
  }

  CameraPosition getCenterCoordinates() {
    LatLngBounds bounds = boundsFromLatLngList(this.run);
    double averageHeight =
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2;
    double averageWidth =
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2;
    return CameraPosition(
        target: LatLng(averageHeight, averageWidth), zoom: 16);
  }

  LatLngBounds boundsFromLatLngList(List<RunData> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (RunData latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longtitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longtitude > y1) y1 = latLng.longtitude;
        if (latLng.longtitude < y0) y0 = latLng.longtitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }
}

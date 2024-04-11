import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:get/get.dart';
import 'package:golden_test/Core/colors.dart';
import 'package:golden_test/Core/constants.dart';
import 'package:latlong2/latlong.dart';
import '../../Controller/LonLatController/lonlat_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const double pointSize = 65;

  final mapController = MapController();

  LatLng? tappedCoords;
  Point<double>? tappedPoint;
  final LonLatController lonLatController = Get.find();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('حدد موقعك بالنقر باستخدام المؤشر')),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text('حدد موقعك على الخريطة')),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: const LatLng(34.5, 36.09),
                initialZoom: 11,
                interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.doubleTapZoom,
                ),
                onTap: (_, latLng) {
                  print('latLang $latLng');
                  final point = mapController.camera
                      .latLngToScreenPoint(tappedCoords = latLng);
                  setState(() => tappedPoint = Point(point.x, point.y));
                  _handleOnMarkerTaped(lat:latLng.latitude,lon:latLng.longitude);
                },
              ),
              children: [
                openStreetMapTileLayer,
                if (tappedCoords != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: pointSize,
                        height: pointSize,
                        point: tappedCoords!,
                        child: const Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
              ],
            ),
            if (tappedPoint != null)
              Positioned(
                left: tappedPoint!.x - 60 / 2,
                top: tappedPoint!.y - 60 / 2,
                child: const IgnorePointer(
                  child: Icon(
                    Icons.location_on_sharp,
                    color: Colors.blue,
                    size: 60,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  _handleOnMarkerTaped({ required double lon,required double lat}) {
    lonLatController.setLongLatValue(lon, lat);
    Get.defaultDialog(
      titlePadding: const EdgeInsets.all(20),
        title: "هل انت متأكد من اختيارك؟",
        backgroundColor: Colors.white,
        titleStyle: const TextStyle(color: Colors.black, fontSize: 20),
        textConfirm: "نعم",
        textCancel: "لا",
        cancelTextColor: Colors.black,
        confirmTextColor: Colors.black,
        buttonColor: kBasicColor,
        barrierDismissible: false,
        radius: kRadius,
        content: const SizedBox(),
        onConfirm: (){
          Navigator.of(context).pop();
          Navigator.of(context).pop();
      }
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      tileProvider: CancellableNetworkTileProvider(),
    );

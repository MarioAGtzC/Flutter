import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderapp/src/models/scan_model.dart';

class MapaPage extends StatelessWidget {
  final map = new MapController();

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: [
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatLng(), 15.0);
            }
          )
        ],
      ),
      body: _crearFlutterMap(scan),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan),
      ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate:'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
      additionalOptions: {
        'accessToken':'pk.eyJ1IjoiZ3JlZW5pZWd0eiIsImEiOiJja2ZjdmJmYWcwMTluMnJxcXptMTYxeHhrIn0.33v7b4ClPV_o8M0kVqZZAA',
        'id': 'mapbox/dark-v10'
        //streets-v10, dark-v10, light-v10, outdoors-v10, satellite-streets-v10
      }
    );
  }

  _crearMarcadores(ScanModel scan) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        ),
        // Marker(
        //   width: 200.0,
        //   height: 200.0,
        //   point: LatLng(19.240981, -103.716307),
        //   builder: (context) => Container(
        //     child: Icon(
        //       Icons.location_on,
        //       size: 45.0,
        //       color: Theme.of(context).primaryColor,
        //     ),
        //   )
        // )
      ]
    );
  }
}
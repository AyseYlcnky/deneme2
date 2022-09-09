import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class contact extends StatefulWidget {
  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  Completer<GoogleMapController> _mapCompleter =
      Completer<GoogleMapController>();

  Map<MarkerId, Marker> _markings = <MarkerId, Marker>{};

  Future _goToLink(String link) async {
    if (await canLaunch(link)) {
      //gelen linki ktrol et eger calisiyosa true donerse
      await launch(link); //gönderdiğim linki çalıştır
    } else {
      debugPrint("I can't open the link you sent");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset('assets/yan_logo2.png'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 300.0,
              width: double.maxFinite,
              child: GoogleMap(
                mapType: MapType.normal,
                markers: Set<Marker>.of(_markings.values),
                initialCameraPosition: CameraPosition(
                  target: LatLng(39.887225, 32.825896),
                  zoom: 15.0,
                ),
                onMapCreated: (GoogleMapController controller) {

                  final MarkerId isaretId = MarkerId('merkez');
                  final Marker isaret = Marker(
                    markerId: isaretId,
                    anchor: const Offset(0.5, 1.0),
                    position: LatLng(39.887225, 32.825896),
                    infoWindow: InfoWindow(
                      title: "FLUTTER NEWS",
                      snippet: "En Güncel Haberler",
                      onTap: () {
                        //haritalarda ac falan demek icin var
                        debugPrint("Marker Clicked");
                      },
                    ),
                  );
                  setState(() {
                    _mapCompleter.complete(controller); //su an olusan controller
                    _markings[isaretId] = isaret;
                  });

                },
              ),
            ),
            Container(
              height: 100,
              child: Center(
                child: Icon(
                  FontAwesomeIcons.home,
                  size: 60,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Aşağı Öveçler, 1309. Sok. No: 2 D:8, 06460                 "
                "Çankaya / ANKARA",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 100,
              child: Center(
                child: Center(
                  child: InkWell(
                      onTap: () {
                        _goToLink("tel: +905350506655");
                      },
                      child: Icon(
                        FontAwesomeIcons.phone,
                        size: 60,
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "0535 050 6655",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 100,
              child: Center(
                child: Center(
                  child: InkWell(
                      onTap: () {
                        _goToLink("mailTo: ayseyalcin8834@gmail.com");
                      },
                      child: Icon(
                        FontAwesomeIcons.envelope,
                        size: 60,
                      )
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
              child: Text(
                "ayseyalcin8834@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

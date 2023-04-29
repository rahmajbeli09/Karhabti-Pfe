import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  Position?cl;
  CameraPosition? _kGooglePlex;


   Future<void> getpos() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

  cl=   await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
        _kGooglePlex = CameraPosition(
        target: LatLng(cl!.latitude, cl!.longitude), zoom: 17.4746);
   }
  Set<Marker> mymarker = {

  };

 Chang(newlat,newlong)async{
    mymarker.remove(Marker(markerId: MarkerId("1")));
    await mymarker.add(Marker(markerId: MarkerId("1"),position: LatLng(newlat, newlong)));
   
  }
@override
void initState() {
  getpos();
  
  super.initState();
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: 
           Center(
            child: 
            Container(
          child: Stack(
            children: [
              GoogleMap(
                markers:mymarker,
                 initialCameraPosition: _kGooglePlex == null
            ? CameraPosition(target: LatLng(2, 3))
            : _kGooglePlex!,
               /* myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                compassEnabled: true,*/
              ),
              Positioned(
                bottom: 20.0,
                left: 150.0,
                child: IconButton(onPressed: ()async{
                  setState(() {
      Chang(cl!.latitude,cl!.longitude);
                  });
                },  
                icon: Icon(Icons.location_searching_rounded,size: 60,) ,
                
                ),
              ),
            ],
          ),
        
        )
           )
            
    );
  }
}
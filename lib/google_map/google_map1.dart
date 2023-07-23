// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_api_headers/google_api_headers.dart';
//
// class SearchPlacesScreen extends StatefulWidget {
//   const SearchPlacesScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
// }
//
// const kGoogleApiKey = 'AIzaSyDCtzDViT3dahNwpdujyFB1dtHe9LgJhUM';
// final homeScaffoldKey = GlobalKey<ScaffoldState>();
//
// class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
//
//
//   Set<Marker> markersList = {};
//
//   late GoogleMapController googleMapController;
//
//   late LatLng currentLocation;
//
//
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   void _getCurrentLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     setState(() {
//       currentLocation = LatLng(position.latitude, position.longitude);
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         title: const Text("Google Search Places"),backgroundColor: Colors.teal,
//
//       ),
//       body:Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(
//          target: currentLocation,
//          zoom: 12.0,
//          ),
//             markers: markersList,
//             mapType: MapType.normal,
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             onMapCreated: (GoogleMapController controller) {
//               googleMapController = controller;
//             },
//           ),
//           IconButton(onPressed: _handlePressButton,icon: Icon(Icons.search),color: Colors.teal,)
//         ],
//       ),
//     );
//   }
//
//   Future<void> _handlePressButton() async {
//     Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: kGoogleApiKey,
//         onError: onError,
//         mode: Mode.overlay,
//         language: 'en',
//         strictbounds: false,
//         types: [""],
//         decoration: InputDecoration(
//             hintText: 'Search',
//             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide(color: Colors.white))),
//         components: [Component(Component.country,"bd")]);
//
//
//     displayPrediction(p!,homeScaffoldKey.currentState);
//   }
//
//   void onError(PlacesAutocompleteResponse response){
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(response.errorMessage!),
//     ));
//
//     // homeScaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(response.errorMessage!)));
//   }
//
//   Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {
//
//     GoogleMapsPlaces places = GoogleMapsPlaces(
//         apiKey: kGoogleApiKey,
//         apiHeaders: await const GoogleApiHeaders().getHeaders()
//     );
//
//     PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
//
//     final lat = detail.result.geometry!.location.lat;
//     final lng = detail.result.geometry!.location.lng;
//
//     markersList.clear();
//     markersList.add(Marker(markerId: const MarkerId("0"),position: LatLng(lat, lng),infoWindow: InfoWindow(title: detail.result.name)));
//
//     setState(() {});
//
//     googleMapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, lng), 14.0));
//
//   }
// }
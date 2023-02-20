import 'package:flutter/material.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/mapview.dart';
import 'package:pois_app/pois.dart';

void main() {
  SdkContext.init(IsolateOrigin.main);
  runApp(const PoisApp());
}

class PoisApp extends StatelessWidget {
  const PoisApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PoisAppPage(title: 'POIs App'),
    );
  }
}

class PoisAppPage extends StatefulWidget {
  const PoisAppPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PoisAppPage> createState() => _PoisAppPageState();
}

class _PoisAppPageState extends State<PoisAppPage> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(children: [
        HereMap(onMapCreated: _onMapCreated),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton.icon(
              onPressed: () {
                MapScene.setPoiVisibility(placeCategories,
                    show ? VisibilityState.visible : VisibilityState.hidden);

                setState(() {
                  show = !show;
                });
              },
              icon: Icon(show ? Icons.visibility : Icons.visibility_off),
              label: Text("${show ? 'Show' : 'Hide'} POI's")),
        )
      ]),
    );
  }

  void _onMapCreated(HereMapController hereMapController) {
    hereMapController.mapScene.loadSceneForMapScheme(MapScheme.normalDay,
        (MapError? error) {
      //If an error of type MapError is thrown, the user is notified
      if (error != null) {
        print('Map scene not loaded. MapError: ${error.toString()}');
        return;
      }
    });
  }
}

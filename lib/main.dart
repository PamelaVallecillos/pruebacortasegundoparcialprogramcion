import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ll_prueba_corta/ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Programacion Movil',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final StreamController<List<String>> _streamController =
      StreamController<List<String>>();

  List<String> _data = [
    "Carlos Mauricio Argeñal Bonilla", "Jorge David Cerna Cabrera", "Jenci Adilson Lemus Cruz", "Denuar Fabian Hernandez Figueroa", "Lilian Yolibeth Bonilla Flores", "Juan Carlos Diaz Gonzalez", "Marcos Ismael Rodriguez Guillen", "Greco Japhet Pavon Hernandez","Carlos Ernesto Sosa Juarez", 
    "Oscar Alejandro Acosta Lanza", "Gerson David Rivera Marquez", "Carlos Roberto Alvarez Matute", "Tania Pamela Vallecillos Mejia", "Axxel Leonardo Arteaga Pavon", "Kenner Hans Barahona Rodriguez", "David Mauricio Figueroa Sosa","Josue David Reyes Yanes", "Hansel Samir Martinez Zavala",];

  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (_) => _emitData());
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamController.close();
    super.dispose();
  }

  List<String> _emitData() {
    _currentIndex = (_currentIndex + 1) % _data.length;

    List<String> newData = _data.sublist(0, _currentIndex + 1);
    _streamController.add(newData);

    return newData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( '       Programacion Movil 432',
          style: TextStyle(color: AppStyles.titleColor,fontWeight: AppStyles.titleFontWeight,),
        ),
        bottom: PreferredSize(
          child: Text('Ingeniero Reynaldo Jose Cruz Ocampo', style: TextStyle(color: AppStyles.subtitleColor,fontWeight: AppStyles.subtitleFontWeight,),
          ),
          preferredSize: Size.fromHeight(20.0),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<List<String>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          snapshot.data![index],
                          style: TextStyle(
                            color: AppStyles.nameColors[index % AppStyles.nameColors.length],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('No hay alumnos registrados en esta clase');
                }
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Cargando datos...');
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Container();
                  }
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

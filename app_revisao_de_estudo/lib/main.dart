import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp()); // meu mein que recebe um fução de windget no caso o MyApp


class MyApp extends StatelessWidget { //    Uma classe que tem estado estatico ou vasio less
  @override
  Widget build(BuildContext context) { // O buid e o construtor que retorna um outro widget na linha de baixo
    return MaterialApp( //esse é o widget que sera retornado e dentro dele posso passar coisas com titulo (title) tema (theme) e home pag principal
      title: 'Usando SharedPreferences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Contador de revisoes de estudo'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _tempo = 1;
  void _incrementCounter() async {

    setState(() {
      _counter++;
      _tempo=_tempo+_counter;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = (prefs.getInt('counter') ?? 0) + 1;
    await prefs.setInt('counter', _counter);

    SharedPreferences prefs2 = await SharedPreferences.getInstance();

    await prefs2.setInt('tempo', _tempo);
  }


  @override
  void initState() {
    _leContador();
    super.initState();
  }
  _leContador() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter =  (prefs.getInt('counter') ?? 0);
    });

    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    setState(() {
      _tempo =  (prefs2.getInt('tempo') ?? 0);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: Icon(Icons.add),
      ),


      body: Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Você revisou :',
            ),
            Text(
              '$_counter vezes' ,
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              'proxima em $_tempo dias' ,
              style: Theme.of(context).textTheme.display1,
            ),
          ],



        ),


      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(

            icon: Icon(Icons.clear),
            title: Text('zerar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          )
        ],
      ),
    );
  }
}
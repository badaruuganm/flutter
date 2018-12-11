import 'package:flutter/material.dart';
import 'qrscanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        buttonColor: Colors.blue,
        buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary
        )
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routes,
    );
  }

  final routes = <String, WidgetBuilder>{
    qrscanner.tag: (context)=> qrscanner()
  };
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Center(
          child : ListView.builder(
            itemBuilder: (BuildContext context, int index) => EntryItem(data[index], context),
            itemCount: data.length,
          )
/*        child: RaisedButton(
          child: Text('QR Scanner'),
          onPressed: () {
            Navigator.of(context).pushNamed(qrscanner.tag);
          },
        ),*/
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Toast',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


// One entry in the multilevel list displayed by this app.
class Entry {
  const Entry(this.title, this.route,[this.children = const <Entry>[]]);
  final String title;
  final String route;
  final List<Entry> children;
}

// Data to display.
const List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    null,
    <Entry>[
      Entry('Barcode Scanner', 'qrscanner'),
    ],
  ),
  Entry(
    'Chapter B',
    null,
    <Entry>[
      Entry('Facebook Auth', 'facebook_login'),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this.context);

  final Entry entry;
  final BuildContext context;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(
        onTap: () { print("I can be tapped but I dont't figure out how to navigate");
        Navigator.of(context).pushNamed(root.route);
        },
        title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

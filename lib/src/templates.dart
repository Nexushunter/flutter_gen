import 'dart:math';

class Templates {
  String _template;
  Templates._();

  factory Templates.simpleWidget(int id) {
    var template =
        "RaisedButton(onPressed: () => print('$id was pressed'), child: Text('$id'),)";
    return Templates._().._template = template;
  }

  factory Templates.complexWidget(int id, int widgetCount) {
    var childWidgets = <String>[];
    for (var i = 0; i < widgetCount; i++) {
      // id = id + (i+1)
      if (i % 10 == 0) {
        // Use a heavily rendered widget
        var grid =
            '''Expanded(flex: 2,child:GridView.builder(itemCount: 60,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5), itemBuilder: (ctx, index) { return Text(index.toString());},),)''';

        childWidgets.add(grid);
      } else if (i % 5 == 0) {
        // Medium rendering
        var imagesURLS = <String>[
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FRandomness&psig=AOvVaw2DLYvxR_230LzGd_8vvan1&ust=1607879244554000&source=images&cd=vfe&ved=2ahUKEwj1_PyK98jtAhXoIjQIHdoVAkQQjRx6BAgAEAc',
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fmkyong.com%2Fjava%2Fjava-generate-random-integers-in-a-range%2F&psig=AOvVaw0FmSowYwDkhCRiETd2Puu5&ust=1607879237879000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKiZxKf3yO0CFQAAAAAdAAAAABAD',
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fblog.habrador.com%2F2013%2F02%2Fhow-to-generate-random-terrain.html&psig=AOvVaw0FmSowYwDkhCRiETd2Puu5&ust=1607879237879000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKiZxKf3yO0CFQAAAAAdAAAAABAJ',
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.lifewire.com%2Fwhat-is-the-random-data-method-2625981&psig=AOvVaw0FmSowYwDkhCRiETd2Puu5&ust=1607879237879000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKiZxKf3yO0CFQAAAAAdAAAAABAP',
        ];

        var src = imagesURLS[Random.secure().nextInt(imagesURLS.length - 1)];
        var image = 'Image.network("$src")';
        childWidgets.add(image);
      } else if (i % 2 == 0) {
        childWidgets.add(Templates.simpleWidget(id + i).toString());
      }
    }

    var container = 'Column(children: [${childWidgets.join(',')},],)';

    var template = 'Container(child: $container,)';
    return Templates._().._template = template;
  }

  // Templated string, for later formatting.
  factory Templates.baseApp() {
    // TODO: Use Navigator 2.0 since this will be for fluttter web
    var base = ''' 
import 'package:flutter/material.dart';
void main() => runApp(BaseApp());

class BaseApp extends StatefulWidget {
  @override
  _BaseAppState createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext ctx) {
 
    return MaterialApp(
      title: 'Flutter Scale Testing',
      home: Scaffold(
        appBar: AppBar(title:Text('Scale Tests'),),
        body: ListView(
          children: [
            Card(child: ListTile(title: Text('Light'),onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (context) => RenderPage(children: _getLight()),),),),),
            Card(child: ListTile(title: Text('Medium'),onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (context) => RenderPage(children: _getMedium()),),),),),
            Card(child: ListTile(title: Text('Heavy'),onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (context) => RenderPage(children: _getHeavy()),),),),),
          ],
        ),
      ),
    );
  }
  
  List<Widget> _getLight() => <Widget>[{lw},];
  List<Widget> _getMedium() => <Widget>[{mw},];
  List<Widget> _getHeavy() => <Widget>[{hw},];
}

class RenderPage extends StatelessWidget {
  final List<Widget> children;
  RenderPage({@required this.children});
  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: children,
    );
  }
}\n''';

    return Templates._().._template = base;
  }

  @override
  String toString() {
    return _template;
  }
}

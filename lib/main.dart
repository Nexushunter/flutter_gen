import 'dart:io';

import 'package:flutter_gen/src/templates.dart';

final helpUsage = 'Usage: flutter_gen <Widget Count>';
void main(List<String> args) {
  if (args.isEmpty) {
    print('Missing number of widgets!');
    print(helpUsage);
    exit(1);
  }

  var widgetCount = int.parse(args[0]);

  print('Generating flutter project with $widgetCount widgets');
  var baseApp = Templates.baseApp().toString();
  var light = <String>[];
  var medium = <String>[];
  var heavy = <String>[];

  var start = DateTime.now();
  for (var i = 0; i < widgetCount % 6; i++) {
    light.add(Templates.simpleWidget(i).toString());
  }

  for (var i = 0; i < widgetCount % 3; i++) {
    if (i % 5 == 0) {
      medium.add(Templates.complexWidget(i, (widgetCount % 3) - i).toString());
    } else {
      medium.add(Templates.simpleWidget(i).toString());
    }
  }

  for (var i = 0; i < widgetCount; i++) {
    if (i % 10 == 0) {
      heavy.add(Templates.complexWidget(i, widgetCount ~/ 10).toString());
    } else if (i % 15 == 0) {
      heavy.add(Templates.complexWidget(i, widgetCount ~/ 15).toString());
    } else {
      heavy.add(Templates.simpleWidget(i).toString());
    }
  }

  var end = DateTime.now();
  print(
      'Generated ${(widgetCount % 6) + (widgetCount % 3) + widgetCount} widgets across 3 pages.');

  print('Total duration: ${end.difference(start)}');
  print('Loading the widgets!');

  // Ensure that web support is actually enabled
  Process.runSync('flutter', ['config', '--enable-web']);

  Process.runSync('flutter', ['create', 'scale_app'],
      workingDirectory: Directory.current.path);
  File _main = File('scale_app/lib/main.dart');
  if (!_main.existsSync()) {
    print(
        'There was an issue creating the flutter scale project. Please ensure correct file permissions');
    exit(1);
  }

  baseApp = baseApp
      .replaceAll('{lw}', light.join(','))
      .replaceAll('{mw}', medium.join(','))
      .replaceAll('{hw}', heavy.join(','));

  _main.writeAsStringSync(baseApp, mode: FileMode.writeOnly);

  print('Finished loading! Formatting...');
  Process.runSync('flutter', ['format', '.'],
      workingDirectory: _main.parent.parent.path);
  print('Formatted!');
}

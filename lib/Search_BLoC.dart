import 'dart:async';
import 'dart:ui';
import 'package:time_constraint/AssistantMethods.dart';

//BLoC creds : https://www.youtube.com/watch?v=oxeYeMHVLII

class QueryChangeEvent {

  String query;

  QueryChangeEvent({required this.query});
}

//Debouncer creds to : https://medium.com/fabcoding/implementing-search-in-flutter-delay-search-while-typing-8508ea4004c6

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class SearchBloc {

  late final Debouncer _debouncer;

  final _searchStateController = StreamController<List<Map<String,String>>>();
  StreamSink<List<Map<String,String>>> get _inLocations => _searchStateController.sink;

  Stream<List<Map<String,String>>> get searchLocation => _searchStateController.stream;

  final _searchEventController = StreamController<QueryChangeEvent>();

  Sink<QueryChangeEvent> get searchEventSink => _searchEventController.sink;

  SearchBloc() {
    _searchEventController.stream.listen(_mapEventToState);
    _debouncer = Debouncer(milliseconds: 1500);
  }
  
  void _mapEventToState(QueryChangeEvent event) {

    _debouncer.run(() {
      AssistantMethods.getSearchLocation(event.query).then((List<Map<String,String>> results) {

        _inLocations.add(results);

      });
    });
  }

  void dispose() {
    _searchEventController.close();
    _searchStateController.close();
  }
  
}
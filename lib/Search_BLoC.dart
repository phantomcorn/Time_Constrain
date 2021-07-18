import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:time_constraint/AssistantMethods.dart';

//creds : https://www.youtube.com/watch?v=oxeYeMHVLII

class QueryChangeEvent {

  String query;

  QueryChangeEvent({required this.query});
}

class SearchBloc {

  final LatLng origin;

  final _searchStateController = StreamController<List<Map<String,String>>>();
  StreamSink<List<Map<String,String>>> get _inLocations => _searchStateController.sink;

  Stream<List<Map<String,String>>> get searchLocation => _searchStateController.stream;

  final _searchEventController = StreamController<QueryChangeEvent>();

  Sink<QueryChangeEvent> get searchEventSink => _searchEventController.sink;

  SearchBloc({required this.origin}) {
    _searchEventController.stream.listen(_mapEventToState);
  }
  
  void _mapEventToState(QueryChangeEvent event) {

    AssistantMethods.getSearchLocation(event.query, origin).then((List<Map<String,String>> results) {

        final List<Map<String,String>> filteredResults = results.where(
                (Map<String,String> location) => location["name"]!.toLowerCase().contains(
                event.query.toLowerCase()
            )
        ).toList();

        _inLocations.add(filteredResults);

      }
    );
  }

  void dispose() {
    _searchEventController.close();
    _searchStateController.close();
  }
  
}
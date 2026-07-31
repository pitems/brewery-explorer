import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<T> debounceRestartable<T>(Duration duration) {
  return (events, mapper) {
    /// Awaits for a set period of time before proceeding to call the event
    final debouncedEvents = events.debounce(duration);

    ///Restartable will receive both the transformed stream (debounceEvents)
    /// and will also receive the event handler(mapper)
    final restartableTransformer = restartable<T>();

    ///Once the time is completed restartable will call the bloc event
    return restartableTransformer(debouncedEvents, mapper);
  };
}

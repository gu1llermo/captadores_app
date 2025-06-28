import 'dart:async';

const Duration defaultDurationDebouncers = Duration(milliseconds: 750);
mixin DebounceMixin {
  final Map<String, Timer?> _debounceTimers = {};
   
  
  void debounce(String key, void Function() callback, {Duration duration = defaultDurationDebouncers}) {
    if (_debounceTimers[key]?.isActive ?? false) _debounceTimers[key]!.cancel();
    
    _debounceTimers[key] = Timer(duration, callback);
  }
  
  void cancelDebounce(String key) {
    _debounceTimers[key]?.cancel();
    _debounceTimers.remove(key);
  }
  
  void cancelAllDebouncers() {
    _debounceTimers.forEach((key, timer) => timer?.cancel());
    _debounceTimers.clear();
  }

  bool isDebounceActive(String key) => _debounceTimers[key]?.isActive ?? false;
  
}
class Utils {

  /* Non-instantiable, only static members */
  const Utils._();

  // TODO: fix some bugs
  static List<Map<String, dynamic>> dispatchThingsboardResponse(final Map<String, dynamic> map) {
    // check if map is empty
    if (map.isEmpty) {
      return <Map<String, dynamic>>[];
    }
    // generate supported data format
    List<Map<String, dynamic>> dispatched = List<Map<String, dynamic>>.generate(
        map.values.first.length, (_) => <String, dynamic>{}, growable: false
    );
    // dispatch
    map.forEach((key, value) {
      List<Map<String, dynamic>> values = List.generate(
          value.length, (index) => value[index], growable: false
      );
      for (int i = 0; i < values.length; i++) {
        dispatched[i]['ts'] = values[i]['ts'];
        dispatched[i][key] = double.tryParse(values[i]['value']) ?? values[i]['value'];
      }
    });
    // return the dispatched data
    return dispatched;
  }

}
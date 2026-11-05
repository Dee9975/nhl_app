import "dart:convert";
import "dart:io";

/// The JSON object saved in `test/fixtures/[name].json`, a real API
/// response captured for parsing tests.
Map<String, dynamic> fixture(String name) {
  final String text = File("test/fixtures/$name.json").readAsStringSync();
  return jsonDecode(text) as Map<String, dynamic>;
}

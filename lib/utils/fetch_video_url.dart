import 'package:http/http.dart' as http;

class Utils {
  Future<String> fetchVideoURL(String yt) async {
    final response = await http.get(Uri.parse(yt));
    Iterable parseAll = _allStringMatches(response.body, RegExp("\"url_encoded_fmt_stream_map\":\"([^\"]*)\""));
    Iterable<String?> parse;
    if (parseAll.toList().isEmpty) {
      parseAll = _allStringMatches(response.body, RegExp("streamingData.*]"));
      parse = _allStringMatches(parseAll.toList()[0], RegExp(r'"url\\":\\".*?\\"'));
      final List<String> urls = parse.toList()[0]!.split(r'":\');
      String finalUrl = Uri.decodeFull(urls[1].substring(1, urls[1].length - 2).replaceAll(r'\\u0026', '&').replaceAll(r'\/', r'/'));
      return finalUrl;
    } else {
      parse = _allStringMatches(parseAll.toList()[0], RegExp("url=(.*)"));
      final List<String> urls = parse.toList()[0]!.split('url=');
      parseAll = _allStringMatches(urls[1], RegExp("([^&,]*)[&,]"));
      String finalUrl = Uri.decodeFull(parseAll.toList()[0]);
      if(finalUrl.indexOf('\\u00') > -1)
        finalUrl = finalUrl.substring(0, finalUrl.indexOf('\\u00'));
      return finalUrl;
    }
  }

  Iterable<String?> _allStringMatches(String text, RegExp regExp) => regExp.allMatches(text).map((m) => m.group(0));

}
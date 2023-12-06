
String? token;

void printFullText(text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element)=> print(element.group(0)!));
}

/*
void printFullText(dynamic text) {
  if (text is Iterable) {
    for (var item in text) {
      if (item is Object && item.toString() is String) {
        final pattern = RegExp('.{1,800}');
        pattern.allMatches(item.toString()).forEach((element) {
          print(element.group(0)!);
        });
      }
    }
  } else if (text is Object && text.toString() is String) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text.toString()).forEach((element) {
      print(element.group(0)!);
    });
  } else {
    print(text);
  }
}*/

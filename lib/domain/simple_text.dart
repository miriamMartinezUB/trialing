class SimpleText {
  final String? title;
  final String? text;
  final List<BulletPoint>? bulletPoints;

  SimpleText({this.title, this.text, this.bulletPoints});

  SimpleText copyWith({String? title, String? text, List<BulletPoint>? bulletPoints}) {
    return SimpleText(
      text: text ?? this.text,
      title: title ?? this.title,
      bulletPoints: bulletPoints ?? this.bulletPoints,
    );
  }
}

class BulletPoint {
  final String text;
  final List<String>? children;

  BulletPoint(this.text, {this.children});
}

class CommentModel {
  late final String rate;
  late final String text;

  CommentModel(this.rate, this.text);

  Map<String, dynamic> toMap() => {
        "rate": rate,
        "text": text,
      };
}

class Post {
  final String name;
  final int numberOfPages;
  final String publisher;
  final String country;

  Post({this.name, this.numberOfPages, this.publisher, this.country});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      name: json['name'],
      numberOfPages: json['numberOfPages'],
      publisher: json['publisher'],
      country: json['country'],
    );
  }
}
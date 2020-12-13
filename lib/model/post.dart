class Post {
  String ownerName;
  DateTime time;
  String content;
  List<String> images;

  Post({this.content, this.images, this.ownerName, this.time});
}

var postData = [
  Post(
      content:
          'Me getting off the bed on Monday morning, realize im just a cat and aint do nothing',
      images: [
        'assets/image/cat1.png',
        'assets/image/cat2.png',
        'assets/image/cat3.png'
      ],
      ownerName: 'PetChoy'),
  Post(
      content:
          'Me getting off the bed on Monday morning, realize im just a cat and aint do nothing',
      images: [
        'assets/image/cat1.png',
        'assets/image/cat2.png',
        'assets/image/cat3.png'
      ],
      ownerName: 'PetChoy'),
  Post(
      content:
          'Me getting off the bed on Monday morning, realize im just a cat and aint do nothing',
      images: [
        'assets/image/cat1.png',
        'assets/image/cat2.png',
        'assets/image/cat3.png'
      ],
      ownerName: 'PetChoy'),
];

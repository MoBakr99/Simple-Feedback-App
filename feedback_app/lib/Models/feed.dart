import 'package:hive/hive.dart';
part 'feed.g.dart';

@HiveType(typeId: 1)
class Feed extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final int rating;

  @HiveField(3)
  final String message;

  Feed({
    required this.name,
    required this.email,
    required this.rating,
    required this.message,
  });
}

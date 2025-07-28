// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/feed.dart';

class FeedbacksScreen extends StatefulWidget {
  const FeedbacksScreen({super.key});

  @override
  State<FeedbacksScreen> createState() => _FeedbacksScreenState();
}

class _FeedbacksScreenState extends State<FeedbacksScreen> {
  _starsRating(Feed feed) {
    return List.generate(
        5,
        (index) => Icon(Icons.star_rounded,
            color: feed.rating >= index + 1 ? Colors.amber : Colors.grey,
            size: 20));
  }

  void _deleteFeedback(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this Feedback?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
    if (confirm == true) {
      final box = Hive.box<Feed>('feedbackBox');
      await box.deleteAt(index);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback deleted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Box<Feed> feedsBox = Hive.box<Feed>('feedbackBox');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedbacks'),
      ),
      body: ValueListenableBuilder(
          valueListenable: feedsBox.listenable(),
          builder: (context, Box<Feed> box, _) {
            if (box.isEmpty) {
              return const Center(child: Text("There's no feedbacks!"));
            }
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final feed = box.getAt(index);
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ..._starsRating(feed!),
                          const SizedBox(width: 5),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text('Name: ${feed.name}'),
                      const SizedBox(height: 5),
                      Text('Email: ${feed.email}'),
                      const SizedBox(height: 9),
                      Text(feed.message),
                      const SizedBox(height: 10),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete Feedback',
                    color: Colors.red,
                    iconSize: 30,
                    onPressed: () {
                      _deleteFeedback(index);
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/feed.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  int _rating = 0;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitFeedback() async {
    if (_formKey.currentState!.validate() && _rating > 0) {
      final feedbackData = Feed(
        name: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        rating: _rating,
        message: _messageController.text.trim(),
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Thank You!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your feedback has been submitted.\n\n'),
                Row(
                  children: [
                    ...List.generate(
                        5,
                        (index) => Icon(
                              Icons.star_rounded,
                              color: feedbackData.rating >= index + 1
                                  ? Colors.amber
                                  : Colors.grey,
                            )),
                  ],
                ),
                Text(
                  'Name: ${feedbackData.name}\n'
                  'Email: ${feedbackData.email}\n'
                  // 'Rating: ${feedbackData.rating} Stars\n'
                  'Message:\n${feedbackData.message}',
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Edit'),
              ),
              TextButton(
                onPressed: () async {
                  final box = Hive.box<Feed>('feedbackBox');
                  await box.add(feedbackData);
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                child: const Text('Send'),
              ),
            ],
          );
        },
      );
    } else if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a star rating')),
      );
    }
  }

  bool _isValidName(String name) {
    return (!name.contains(RegExp(r'[^a-zA-Z\s]')) && name.length >= 3);
  }

  bool _isValidEmail(String email) {
    return email.endsWith('@gmail.com') ||
        email.endsWith('@yahoo.com') ||
        email.endsWith('@hotmail.com') ||
        email.endsWith('@outlook.com');
  }

  Widget _buildStarRating() {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(
        IconButton(
          onPressed: () {
            setState(() {
              _rating = i;
            });
          },
          icon: Icon(
            Icons.star_rounded,
            color: i <= _rating ? Colors.amber : Colors.grey,
            size: 32,
          ),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) =>
                    value == null || value.isEmpty || !_isValidName(value)
                        ? 'Please enter a valid name'
                        : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value == null || value.isEmpty || !_isValidEmail(value)
                        ? 'Please enter a valid email'
                        : null,
              ),
              const SizedBox(height: 10),
              const Text(
                'Rating',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              _buildStarRating(),
              const SizedBox(height: 10),
              TextFormField(
                controller: _messageController,
                decoration:
                    const InputDecoration(labelText: 'Feedback Message'),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your feedback'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitFeedback,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Send Feedback',
                      textScaler: TextScaler.linear(1.1),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.send),
                    // How to center the text and icon together?
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

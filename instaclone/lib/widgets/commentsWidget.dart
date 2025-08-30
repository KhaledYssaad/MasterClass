import 'package:flutter/material.dart';
import "../models/commentModel.dart";
import "../services/commentsService.dart"; // ApiService

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final TextEditingController _controller = TextEditingController();
  List<CommentModel> _comments = [];
  bool _loading = true;
  bool _loadedOnce = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    if (_loadedOnce) return; // don't reload on rebuilds
    _loadedOnce = true;

    final fetched = await ApiService.fetchComments(); // from assets
    setState(() {
      _comments = fetched;
      _loading = false;
    });
  }

  void _addComment(String text) {
    if (text.trim().isEmpty) return;

    final newComment = CommentModel(
      username: "you",
      profileImage: "https://i.pravatar.cc/150?img=12",
      text: text,
      time: "now",
    );

    setState(() {
      _comments.insert(0, newComment);
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 8, bottom: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Title
          const Center(
            child: Text(
              "Comments",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : _comments.isEmpty
                ? const Center(
                    child: Text(
                      "No comments yet",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _comments.length,
                    itemBuilder: (context, index) {
                      final c = _comments[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(c.profileImage),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        c.username,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        c.time,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    c.text,
                                    style: TextStyle(
                                      color: Colors.grey[300],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // Input field + send button
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Add a comment...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[850],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                  onSubmitted: _addComment,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: () => _addComment(_controller.text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

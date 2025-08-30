import 'package:flutter/material.dart';
import "./commentsWidget.dart";

class Post extends StatelessWidget {
  final String username;
  final String profileImage;
  final String postImage;
  final String caption;

  const Post({
    super.key,
    required this.username,
    required this.profileImage,
    required this.postImage,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Suggested for you",
                        style: TextStyle(color: Colors.grey[300], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Follow",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("More options clicked"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),

        Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(postImage),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.comment_outlined, color: Colors.white),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return const CommentWidget();
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share_outlined, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                caption,
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            '1 hour ago',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

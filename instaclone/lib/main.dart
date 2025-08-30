import 'package:flutter/material.dart';
import 'models/postModel.dart';
import 'services/apiService.dart';
import 'widgets/post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomAppBar(),
        body: FutureBuilder<List<PostModel>>(
          future: ApiService.fetchPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: TextStyle(color: Colors.white),
                ),
              );
            } else {
              final posts = snapshot.data!;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Post(
                    username: post.username,
                    profileImage: post.profileImage,
                    postImage: post.postImage,
                    caption: post.caption,
                  );
                },
              );
            }
          },
        ),
        bottomNavigationBar: Footer(),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Color _buttonColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),

      title: Row(
        children: [
          MouseRegion(
            onEnter: (_) {
              setState(() {
                // Change the color on hover
                _buttonColor = Colors.grey[700]!;
              });
            },
            onExit: (_) {
              setState(() {
                // Reset color when hover ends
                _buttonColor = Colors.white;
              });
            },
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: _buttonColor),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Clicked!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 10),
          Text("Explore", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      padding: EdgeInsets.symmetric(vertical: 4),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined, color: Colors.white),
            onPressed: () {
              print("Home clicked");
            },
          ),

          IconButton(
            icon: Icon(Icons.search_outlined, color: Colors.white),
            onPressed: () {
              print("Search clicked");
            },
          ),

          IconButton(
            icon: Icon(Icons.add_box_outlined, color: Colors.white),
            onPressed: () {
              print("Add Post clicked");
            },
          ),

          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              print("Activity clicked");
            },
          ),

          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQytc93VfA29gwZ4w1ySdWjx1CSJBM6qGG3BA&s',
            ),
          ),
        ],
      ),
    );
  }
}

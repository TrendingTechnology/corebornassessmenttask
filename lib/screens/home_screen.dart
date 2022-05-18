import 'package:corebornassessmenttask/models/post_model.dart';
import 'package:corebornassessmenttask/providers/main_provider.dart';
import 'package:corebornassessmenttask/screens/post_screen.dart';
import 'package:corebornassessmenttask/screens/users_screen.dart';
import 'package:corebornassessmenttask/utils/project_utils.dart';
import 'package:corebornassessmenttask/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void showSnackBarMessage(String message) => ProjectUtils.showSnackBarMessage(context, message);

  @override
  void initState() {
    fetchPost();
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading && !allLoaded) {
          fetchPost();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  List<PostModel> posts = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();

  fetchPost() async {
    setState(() {
      loading = true;
    });
    List<PostModel> sourcePosts = context.read<MainProvider>().posts;
    if (sourcePosts.isEmpty) {
      String response = await context.read<MainProvider>().getPosts();
      if (response != '0') {
        showSnackBarMessage(response);
        setState(() {
          loading = false;
        });
        return;
      } else {
        if (mounted) sourcePosts = context.read<MainProvider>().posts;
      }
    }
    if (posts.length == sourcePosts.length) {
      setState(() {
        allLoaded = true;
      });
    } else {
      setState(
        () {
          if (sourcePosts.length - posts.length < 8) {
            sourcePosts.getRange(posts.length, sourcePosts.length).forEach(
              (element) {
                posts.add(element);
              },
            );
          } else {
            sourcePosts.getRange(posts.length, posts.length + 8).forEach(
              (element) {
                posts.add(element);
              },
            );
          }
        },
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Assessment App'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: false,
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UsersScreen()));
              },
              icon: Icon(
                Icons.contacts_sharp,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              label: Text(
                'Users',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
        body: posts.isEmpty
            ? ProjectUtils.circularProgressBar(context)
            : Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostWidget(
                        post: posts[index],
                        onPress: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostScreen(post: posts[index]),
                          ),
                        ),
                      );
                    },
                  ),
                  if (loading)
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: SizedBox(
                        height: 80.h,
                        width: MediaQuery.of(context).size.width,
                        child: ProjectUtils.circularProgressBar(context),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

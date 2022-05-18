import 'package:corebornassessmenttask/models/comment_model.dart';
import 'package:corebornassessmenttask/models/post_model.dart';
import 'package:corebornassessmenttask/utils/project_utils.dart';
import 'package:corebornassessmenttask/widgets/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';

class PostScreen extends StatefulWidget {
  final PostModel post;
  const PostScreen({super.key, required this.post});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void showSnackBarMessage(String message) => ProjectUtils.showSnackBarMessage(context, message);

  @override
  void initState() {
    context.read<MainProvider>().postComments = [];
    fetchComments();
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading && !allLoaded) {
          fetchComments();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  fetchComments() async {
    setState(() {
      loading = true;
    });
    List<CommentModel> sourceComments = context.read<MainProvider>().postComments;
    if (sourceComments.isEmpty) {
      String response = await context.read<MainProvider>().getCommentsForPost(widget.post.id);
      if (response != '0') {
        showSnackBarMessage(response);
        setState(() {
          loading = false;
        });
        return;
      } else {
        if (mounted) sourceComments = context.read<MainProvider>().postComments;
      }
    }

    if (comments.length == sourceComments.length) {
      setState(() {
        allLoaded = true;
      });
    } else {
      setState(
        () {
          if (sourceComments.length - comments.length < 8) {
            sourceComments.getRange(comments.length, sourceComments.length).forEach(
              (element) {
                comments.add(element);
              },
            );
          } else {
            sourceComments.getRange(comments.length, comments.length + 8).forEach(
              (element) {
                comments.add(element);
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

  List<CommentModel> comments = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();
  int likeCount = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          centerTitle: false,
          title: const Text('Post'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: false,
            children: [
              Text(
                'post #${widget.post.id} -- user #${widget.post.userId}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                ),
              ),
              Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                ),
              ),
              Row(
                children: [
                  TextButton.icon(
                    label: Text('$likeCount likes'),
                    onPressed: () {
                      setState(() {
                        if (likeCount == 0) {
                          likeCount++;
                        } else {
                          likeCount--;
                        }
                      });
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/like.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/comment.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/share.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/icons/retweet.svg',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              comments.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ProjectUtils.circularProgressBar(context),
                    )
                  : Stack(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return CommentWidget(comment: comments[index]);
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
            ],
          ),
        ),
      ),
    );
  }
}

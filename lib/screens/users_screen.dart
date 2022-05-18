import 'package:corebornassessmenttask/models/user_model.dart';
import 'package:corebornassessmenttask/utils/project_utils.dart';
import 'package:corebornassessmenttask/widgets/user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  void showSnackBarMessage(String message) => ProjectUtils.showSnackBarMessage(context, message);

  @override
  void initState() {
    fetchUsers();
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !loading && !allLoaded) {
          fetchUsers();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  fetchUsers() async {
    setState(() {
      loading = true;
    });
    List<UserModel> sourceUsers = context.read<MainProvider>().users;
    if (sourceUsers.isEmpty) {
      String response = await context.read<MainProvider>().getUsers();
      if (response != '0') {
        showSnackBarMessage(response);
        setState(() {
          loading = false;
        });
        return;
      } else {
        if (mounted) sourceUsers = context.read<MainProvider>().users;
      }
    }

    if (users.length == sourceUsers.length) {
      setState(() {
        allLoaded = true;
      });
    } else {
      setState(
        () {
          if (sourceUsers.length - users.length < 8) {
            sourceUsers.getRange(users.length, sourceUsers.length).forEach(
              (element) {
                users.add(element);
              },
            );
          } else {
            sourceUsers.getRange(users.length, users.length + 8).forEach(
              (element) {
                users.add(element);
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

  List<UserModel> users = [];
  bool loading = false, allLoaded = false;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const Text('Users'),
          centerTitle: false,
        ),
        body: users.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProjectUtils.circularProgressBar(context),
              )
            : Stack(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return UserWidget(user: users[index]);
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

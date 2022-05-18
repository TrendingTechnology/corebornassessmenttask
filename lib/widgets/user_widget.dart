import 'package:corebornassessmenttask/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserWidget extends StatefulWidget {
  final UserModel user;
  const UserWidget({super.key, required this.user});

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Material(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'user #${widget.user.id} @${widget.user.username}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      widget.user.name,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.email),
                        const SizedBox(width: 4),
                        Text(
                          widget.user.email,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        const SizedBox(width: 4),
                        Text(
                          widget.user.phone,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.language),
                        const SizedBox(width: 4),
                        Text(
                          widget.user.website,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.business),
                        const SizedBox(width: 4),
                        Text(
                          widget.user.company.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_city),
                        const SizedBox(width: 4),
                        Text(
                          widget.user.address.city,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Album count: ${widget.user.albumCount}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      'Post count: ${widget.user.postCount}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
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

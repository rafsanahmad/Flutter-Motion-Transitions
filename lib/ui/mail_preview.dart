/*
 * *
 *  * Created by Rafsan Ahmad on 11/6/21, 6:40 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/model/model_email.dart';
import 'package:flutter_motion_transitions/ui/profile_avater.dart';
import 'package:provider/provider.dart';

class MailPreview extends StatelessWidget {
  const MailPreview({
    required this.id,
    required this.email,
    this.onStar,
    this.onDelete,
  });

  final int id;
  final Email email;
  final VoidCallback? onStar;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var emailStore = Provider.of<EmailStore>(
      context,
      listen: false,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: constraints.maxHeight),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${email.sender} - ${email.time}',
                            style: textTheme.caption,
                          ),
                          const SizedBox(height: 4),
                          Text(email.subject, style: textTheme.headline5),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    _MailPreviewActionBar(
                      avatar: email.avatar,
                      isStarred: emailStore.isEmailStarred(email),
                      onStar: onStar,
                      onDelete: onDelete,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 20,
                  ),
                  child: Text(
                    email.message,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: textTheme.bodyText2,
                  ),
                ),
                if (email.containsPictures) ...[
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      children: const [
                        SizedBox(height: 20),
                        _PicturePreview(),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PicturePreview extends StatelessWidget {
  const _PicturePreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: 4),
            child: Image.asset(
              'reply/attachments/paris_${index + 1}.jpg',
              gaplessPlayback: true,
              package: 'flutter_gallery_assets',
            ),
          );
        },
      ),
    );
  }
}

class _MailPreviewActionBar extends StatelessWidget {
  const _MailPreviewActionBar({
    required this.avatar,
    required this.isStarred,
    this.onStar,
    this.onDelete,
  });

  final String avatar;
  final bool isStarred;
  final VoidCallback? onStar;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(avatar: avatar),
      ],
    );
  }
}

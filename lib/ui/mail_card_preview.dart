/*
 * *
 *  * Created by Rafsan Ahmad on 11/6/21, 6:40 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/model/model_email.dart';
import 'package:flutter_motion_transitions/pages/mail_view_page.dart';
import 'package:flutter_motion_transitions/utils/colors.dart';
import 'package:provider/provider.dart';

import 'mail_preview.dart';

class MailPreviewCard extends StatelessWidget {
  const MailPreviewCard({
    Key? key,
    required this.id,
    required this.email,
    required this.onDelete,
    required this.onStar,
  }) : super(key: key);

  final int id;
  final Email email;
  final VoidCallback onDelete;
  final VoidCallback onStar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final currentEmailStarred = Provider.of<EmailStore>(
      context,
      listen: false,
    ).isEmailStarred(email);

    final colorScheme = theme.colorScheme;
    final mailPreview = MailPreview(
      id: id,
      email: email,
      onStar: onStar,
      onDelete: onDelete,
    );
    final onStarredInbox = Provider.of<EmailStore>(
          context,
          listen: false,
        ).currentlySelectedInbox ==
        'Starred';

    return _OpenContainerWrapper(
      id: id,
      email: email,
      closedChild: Dismissible(
        key: ObjectKey(email),
        dismissThresholds: const {
          DismissDirection.startToEnd: 0.8,
          DismissDirection.endToStart: 0.4,
        },
        onDismissed: (direction) {
          switch (direction) {
            case DismissDirection.endToStart:
              if (onStarredInbox) {
                onStar();
              }
              break;
            case DismissDirection.startToEnd:
              onDelete();
              break;
            default:
          }
        },
        background: _DismissibleContainer(
          icon: 'twotone_delete',
          backgroundColor: colorScheme.primary,
          iconColor: ReplyColors.blue50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsetsDirectional.only(start: 20),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            if (onStarredInbox) {
              return true;
            }
            onStar();
            return false;
          } else {
            return true;
          }
        },
        secondaryBackground: _DismissibleContainer(
          icon: 'twotone_star',
          backgroundColor: currentEmailStarred
              ? colorScheme.secondary
              : theme.scaffoldBackgroundColor,
          iconColor: currentEmailStarred
              ? colorScheme.onSecondary
              : colorScheme.onBackground,
          alignment: Alignment.centerRight,
          padding: const EdgeInsetsDirectional.only(end: 20),
        ),
        child: mailPreview,
      ),
    );
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.id,
    required this.email,
    required this.closedChild,
  });

  final int id;
  final Email email;
  final Widget closedChild;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OpenContainer(
      openBuilder: (context, closedContainer) {
        return MailViewPage(id: id, email: email);
      },
      openColor: theme.cardColor,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      closedElevation: 0,
      closedColor: theme.cardColor,
      closedBuilder: (context, openContainer) {
        return InkWell(
          onTap: () {
            Provider.of<EmailStore>(
              context,
              listen: false,
            ).currentlySelectedEmailId = id;
            openContainer();
          },
          child: closedChild,
        );
      },
    );
  }
}

class _DismissibleContainer extends StatelessWidget {
  const _DismissibleContainer({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.alignment,
    required this.padding,
  });

  final String icon;
  final Color backgroundColor;
  final Color iconColor;
  final Alignment alignment;
  final EdgeInsetsDirectional padding;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: alignment,
      color: backgroundColor,
      curve: standardEasing,
      duration: kThemeAnimationDuration,
      padding: padding,
      child: Material(
        color: Colors.transparent,
        child: ImageIcon(
          AssetImage(
            'reply/icons/$icon.png',
            package: 'flutter_gallery_assets',
          ),
          size: 36,
          color: iconColor,
        ),
      ),
    );
  }
}

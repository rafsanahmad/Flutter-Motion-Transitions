/*
 * *
 *  * Created by Rafsan Ahmad on 11/8/21, 2:32 AM
 *  * Copyright (c) 2021 . All rights reserved.
 *
 */

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/model/model_email.dart';
import 'package:flutter_motion_transitions/pages/mail_view_page.dart';
import 'package:provider/provider.dart';

class ListToDetailContainerWrapper extends StatelessWidget {
  const ListToDetailContainerWrapper({
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

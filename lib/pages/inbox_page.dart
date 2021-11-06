/*
 * *
 *  * Created by Rafsan Ahmad on 11/2/21, 7:52 PM
 *  * Copyright (c) 2021 . All rights reserved.
 *  
 */

import 'package:flutter/material.dart';
import 'package:flutter_motion_transitions/model/email_store.dart';
import 'package:flutter_motion_transitions/ui/mail_card_preview.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatelessWidget {
  const InboxPage({required this.destination, Key? key}) : super(key: key);

  final String destination;

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 4.0;

    return Consumer<EmailStore>(
      builder: (context, model, child) {
        return SafeArea(
          bottom: false,
          child: model.emails[destination]!.isEmpty
              ? Center(
                  child: Text(
                    'Empty in ${destination.toLowerCase()}',
                  ),
                )
              : ListView.separated(
                  itemCount: model.emails[destination]!.length,
                  padding: const EdgeInsetsDirectional.only(
                    start: horizontalPadding,
                    end: horizontalPadding,
                    bottom: kToolbarHeight,
                  ),
                  primary: false,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    return MailPreviewCard(
                      id: index,
                      email: model.emails[destination]!.elementAt(index),
                      onDelete: () => model.deleteEmail(destination, index),
                      onStar: () => model.starEmail(destination, index),
                    );
                  },
                ),
        );
      },
    );
  }
}

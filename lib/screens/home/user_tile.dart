import 'package:flutter/material.dart';

import '../../models/fuser.dart';

class UserTile extends StatelessWidget {
  final FUser fuser;

  UserTile({required this.fuser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Color.fromARGB(255, 218, 220, 221),
          ),
          title: Text(fuser.fullName.toString()),
          subtitle: Text('Mobile: ${fuser.mobile} Age: ${fuser.age}'),
        ),
      ),
    );
  }
}

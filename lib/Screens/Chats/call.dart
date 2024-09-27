import 'package:chatnew/CommonComponents/custom_app_bar.dart';
import 'package:flutter/material.dart';

class Call extends StatelessWidget {
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
            centertitle: false,
            appBarBGColor: Theme.of(context).colorScheme.primary,
            titleChild: const Text('Call',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
            actionsWidget: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined, color: Colors.white,))
            ],
          ),
      body: SafeArea(
        child: Center(
          child: Text("Call Screen",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),),
        ),
      ),
    );
  }
}
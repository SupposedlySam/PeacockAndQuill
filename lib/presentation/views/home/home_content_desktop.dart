import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/components/lifecycle_managers/key_press_page_manager.dart';

class HomeContentDesktop extends StatelessWidget {
  static List<Widget> pages = [
    Center(
      child: Column(children: [
        Expanded(
          child: Center(
            child: TextFormField(),
          ),
        ),
        RaisedButton(child: Text("My Button"), onPressed: () {}),
      ]),
    ),
    Center(child: Text('Home Page 2')),
    Center(child: Text('Home Page 3')),
    Center(child: Text('Home Page 4')),
    Center(child: Text('Home Page 5')),
  ];

  @override
  Widget build(BuildContext context) {
    return KeyPressPageManager(
      builder: (context, controller) {
        return PageView.builder(
          controller: controller,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
        );
      },
    );
  }
}

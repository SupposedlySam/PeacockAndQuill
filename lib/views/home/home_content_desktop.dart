import 'package:flutter/material.dart';
import 'package:peacock_and_quill/components/lifecycle_managers/key_press_page_manager.dart';

class HomeContentDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return KeyPressPageManager(
      builder: (context, controller) {
        return PageView(
          controller: controller,
          children: [
            Center(child: Text('Home Page 1')),
            Center(child: Text('Home Page 2')),
            Center(child: Text('Home Page 3')),
            Center(child: Text('Home Page 4')),
            Center(child: Text('Home Page 5')),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_desktop.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_content_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
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
    return ScreenTypeLayout(
      tablet: HomeContentDesktop(pages: pages),
      mobile: HomeContentMobile(pages: pages),
    );
  }
}

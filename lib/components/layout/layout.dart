import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:podfy/components/navbar/navigation-menu.dart';

class Layout extends StatefulWidget {
  final String titulo;
  final Widget child;

  const Layout({Key? key, required this.titulo, required this.child,}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(widget.titulo),
      ),
      body: Center(child: widget.child),
      bottomNavigationBar: NavigationMenu(),
    );  }
}

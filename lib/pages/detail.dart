import 'package:flutter/material.dart';
import 'package:note_project/data/model/note.dart';

class DetailPage extends StatefulWidget {
  final Note? note;
  DetailPage({super.key, this.note});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App Notes"),
        ),
        body: Column(
          children: [Text(widget.note!.title)],
        ));
  }
}

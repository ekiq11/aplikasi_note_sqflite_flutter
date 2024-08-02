import 'package:flutter/material.dart';
import 'package:note_project/data/datasource/local_datasource.dart';
import 'package:note_project/data/model/note.dart';

class EditNote extends StatefulWidget {
  final Note? note;
  const EditNote({super.key, this.note});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: "Edit Title Note", border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pelease Enter Judul';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: contentController,
                decoration: const InputDecoration(
                    labelText: "Edit Content Note",
                    border: OutlineInputBorder()),
                maxLines: 8,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pelease Enter Content';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Note note = Note(
                          id: widget.note!.id,
                          title: titleController.text,
                          content: contentController.text,
                          createdAt: DateTime.now());
                      LocalDatabase().updateNoteById(note);
                      titleController.clear;
                      contentController.clear;
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Note berhasil disimpan")));
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Simpan"))
            ],
          ),
        ),
      ),
    );
  }
}

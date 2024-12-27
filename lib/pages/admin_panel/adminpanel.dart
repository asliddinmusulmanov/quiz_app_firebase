import 'package:flutter/material.dart';
import 'package:app_quiz/data/models/savollar_model.dart';
import 'package:app_quiz/pages/admin_panel/data.dart';
import 'package:app_quiz/pages/departments/ctr_departments.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  String? collectionpath;
  String modul = '1modul';
  String? dars;
  String? level;

  final TextEditingController questionController = TextEditingController();
  final TextEditingController variantAController = TextEditingController();
  final TextEditingController variantBController = TextEditingController();
  final TextEditingController variantCController = TextEditingController();
  bool correctA = false;
  bool correctB = false;
  bool correctC = false;

  void _onDropdownChanged(String? newValue) {
    setState(() {
      collectionpath = newValue;
    });
    if (newValue != null) {
      debugPrint('Selected value: $collectionpath');
    }
  }

  void _onDropdowMmodul(String? newValue) {
    setState(() {
      modul = newValue!;
      dars = null; // darsni qayta o'rnatish
    });
    if (newValue != null) {
      debugPrint('Selected value: $modul');
    }
  }

  void _onDropdowLesson(String? newValue) {
    setState(() {
      dars = newValue;
    });
    if (newValue != null) {
      debugPrint('Selected value: $dars');
    }
  }

  void _onDropdowLevel(String? newValue) {
    setState(() {
      level = newValue;
    });
    if (newValue != null) {
      debugPrint('Selected value: $level');
    }
  }

  void _saveQuestion() {
    final newQuestion = TestModelList(
      savol: questionController.text,
      variant: [
        Variant(key: 'A', text: variantAController.text, javob: correctA),
        Variant(key: 'B', text: variantBController.text, javob: correctB),
        Variant(key: 'C', text: variantCController.text, javob: correctC),
      ],
    );
    SavollarController.addQuestion(
        newQuestion, setState, collectionpath!, modul, dars!, level!);

    // Clear the TextFields and reset the checkboxes
    questionController.clear();
    variantAController.clear();
    variantBController.clear();
    variantCController.clear();
    setState(() {
      correctA = false;
      correctB = false;
      correctC = false;
    });

    // Show a Snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Question saved successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Question'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: collectionpath,
                  hint: const Text('Select Language'),
                  items: QuestionData.languages.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(entry.label),
                    );
                  }).toList(),
                  onChanged: _onDropdownChanged,
                ),
                DropdownButton<String>(
                  value: modul,
                  hint: const Text('Select Module'),
                  items: QuestionData.modullar.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(entry.label),
                    );
                  }).toList(),
                  onChanged: _onDropdowMmodul,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: dars,
                  hint: const Text('Language Lesson'),
                  items: QuestionData.darslar(modul).map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(entry.label),
                    );
                  }).toList(),
                  onChanged: _onDropdowLesson,
                ),
                DropdownButton<String>(
                  value: level,
                  hint: const Text('Language Lesson Level'),
                  items: QuestionData.level.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(entry.label),
                    );
                  }).toList(),
                  onChanged: _onDropdowLevel,
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                hintText: 'Add a question',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: variantAController,
              decoration: const InputDecoration(
                hintText: 'Variant A',
                border: OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
              title: const Text('To\'g\'ri javob A'),
              value: correctA,
              onChanged: (bool? value) {
                setState(() {
                  correctA = value ?? false;
                });
              },
            ),
            TextField(
              controller: variantBController,
              decoration: const InputDecoration(
                hintText: 'Variant B',
                border: OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
              title: const Text('To\'g\'ri javob B'),
              value: correctB,
              onChanged: (bool? value) {
                setState(() {
                  correctB = value ?? false;
                });
              },
            ),
            TextField(
              controller: variantCController,
              decoration: const InputDecoration(
                hintText: 'Variant C',
                border: OutlineInputBorder(),
              ),
            ),
            CheckboxListTile(
              title: const Text('To\'g\'ri javob C'),
              value: correctC,
              onChanged: (bool? value) {
                setState(() {
                  correctC = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveQuestion,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class DropdownMenuEntry<T> {
  final T value;
  final String label;

  DropdownMenuEntry({required this.value, required this.label});
}

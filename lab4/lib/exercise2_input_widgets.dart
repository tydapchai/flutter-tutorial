import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _sliderValue = 50;
  bool _switchValue = false;
  int? _radioValue;

  @override
  Widget build(BuildContext context) {
    String genreText = 'None';
    if (_radioValue == 1) genreText = 'Action';
    if (_radioValue == 2) genreText = 'Comedy';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Contr...', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Rating (Slider)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              onChanged: (val) {
                setState(() => _sliderValue = val);
              },
            ),
            Text('Current value: \${_sliderValue.round()}', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),
            
            const Text('Active (Switch)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Is movie active?', style: TextStyle(fontSize: 15, color: Colors.black87)),
                Switch(
                  value: _switchValue,
                  onChanged: (val) {
                    setState(() => _switchValue = val);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            const Text('Genre (RadioListTile)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            RadioListTile<int>(
              title: const Text('Action'),
              value: 1,
              groupValue: _radioValue,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) {
                setState(() => _radioValue = val);
              },
            ),
            RadioListTile<int>(
              title: const Text('Comedy'),
              value: 2,
              groupValue: _radioValue,
              contentPadding: EdgeInsets.zero,
              onChanged: (val) {
                setState(() => _radioValue = val);
              },
            ),
            Text('Selected genre: $genreText', style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F2F8),
                  foregroundColor: Colors.indigo,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                },
                child: const Text('Open Date Picker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

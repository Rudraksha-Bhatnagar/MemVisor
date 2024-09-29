import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/models/process.dart';
import 'package:project/memory_managment/memory.dart';

class SegmentationPage extends StatefulWidget {
  @override
  _SegmentationPageState createState() => _SegmentationPageState();
}

class _SegmentationPageState extends State<SegmentationPage> {
  final _segmentNumberController = TextEditingController();
  final _offsetController = TextEditingController();
  final _baseAddressController = TextEditingController();
  String _physicalAddress = '';

  // Function to calculate physical address
  void _calculatePhysicalAddress() {
    final segmentNumber = int.tryParse(_segmentNumberController.text) ?? -1;
    final offset = int.tryParse(_offsetController.text) ?? -1;
    final baseAddress = int.tryParse(_baseAddressController.text) ?? -1;

    if (segmentNumber >= 0 && offset >= 0 && baseAddress >= 0) {
      setState(() {
        _physicalAddress = 'Physical Address: ${baseAddress + offset}';
      });
    } else {
      setState(() {
        _physicalAddress = 'Invalid input!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final memoryManager = Provider.of<MemoryManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Segmentation Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Segment Input Section
            TextField(
              controller: _segmentNumberController,
              decoration: InputDecoration(
                labelText: 'Segment Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            // Offset Input Section
            TextField(
              controller: _offsetController,
              decoration: InputDecoration(
                labelText: 'Offset',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            // Base Address Input Section (for the given segment)
            TextField(
              controller: _baseAddressController,
              decoration: InputDecoration(
                labelText: 'Base Address of Segment',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _calculatePhysicalAddress,
              child: Text('Calculate Physical Address'),
            ),
            const SizedBox(height: 10),
            Text(
              _physicalAddress,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: memoryManager.processes.length,
                itemBuilder: (context, index) {
                  final process = memoryManager.processes[index];
                  return ListTile(
                    title: Text('Process: ${process.name}, Size: ${process.size} blocks'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

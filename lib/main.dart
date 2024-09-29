import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memory_managment/memory.dart';
import 'memory_managment/grid.dart';
import 'memory_managment/segmentation_page.dart'; // Import Segmentation Page

void main() {
  runApp(MemoryManagementApp());
}

class MemoryManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemoryManager(),
      child: MaterialApp(
        title: 'Memory Management Simulator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MemoryManagementHomePage(),
      ),
    );
  }
}

class MemoryManagementHomePage extends StatefulWidget {
  @override
  _MemoryManagementHomePageState createState() => _MemoryManagementHomePageState();
}

class _MemoryManagementHomePageState extends State<MemoryManagementHomePage> {
  final _nameController = TextEditingController();
  final _sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final memoryManager = Provider.of<MemoryManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Management Simulator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Algorithm selection dropdown
            DropdownButton<String>(
              value: memoryManager.selectedAlgorithm,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  if (newValue == 'Segmentation') {
                    // Navigate to the Segmentation Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SegmentationPage()), // Navigate to segmentation
                    );
                  } else {
                    memoryManager.setAlgorithm(newValue); // Set other algorithms
                  }
                }
              },
              items: ['First Fit', 'Best Fit', 'Worst Fit', 'Buddy System', 'Paging', 'Segmentation']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            // Process Input Section
            Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Process Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _sizeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Size',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final name = _nameController.text;
                    final size = int.tryParse(_sizeController.text) ?? 0;
                    if (name.isNotEmpty && size > 0) {
                      memoryManager.addProcess(name, size);
                      _nameController.clear();
                      _sizeController.clear();
                    }
                  },
                  child: Text('Add Process'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    memoryManager.resetMemory();
                  },
                  child: Text('Reset Memory'),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Memory Grid
            SizedBox(
              height: 200, // Adjust the height as needed
              child: MemoryGrid(memoryBlocks: memoryManager.memoryBlocks),
            ),
            const SizedBox(height: 10),
            const Text('Processes:'),
            Expanded(
              child: ListView.builder(
                itemCount: memoryManager.processes.length,
                itemBuilder: (context, index) {
                  final process = memoryManager.processes[index];

                  return ListTile(
                    title: Text('${process.name} - ${process.size} blocks'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        memoryManager.deleteProcess(process.name); // Delete process by name
                      },
                    ),
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

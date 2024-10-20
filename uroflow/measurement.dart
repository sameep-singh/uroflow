// views/measurement.dart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dashboard.dart'; // Import the DashboardPage

class MeasurementPage extends StatefulWidget {
  final String name;
  final String email;
  final String role;

  const MeasurementPage({
    super.key,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  _MeasurementPageState createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  final TextEditingController _flowRateController = TextEditingController();
  List<FlSpot> dataPoints = [];

  void _addDataPoint() {
    if (_flowRateController.text.isNotEmpty) {
      double flowRate = double.tryParse(_flowRateController.text) ?? 0.0;
      setState(() {
        dataPoints.add(FlSpot(dataPoints.length.toDouble(), flowRate));
      });
      _flowRateController.clear(); // Clear the input field after adding data
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a flow rate')),
      );
    }
  }

  void _goToDashboard() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardPage(
          name: widget.name,
          email: widget.email,
          role: widget.role,
          dataPoints: dataPoints,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Urine Flow Measurement")),
      body: Column(
        children: [
          TextField(
            controller: _flowRateController,
            decoration: const InputDecoration(labelText: "Enter flow rate"),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: _addDataPoint,
            child: const Text("Add Data Point"),
          ),
          ElevatedButton(
            onPressed: _goToDashboard,
            child: const Text("Go to Dashboard"),
          ),
          Expanded(
            child: dataPoints.isNotEmpty
                ? LineChart(LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: dataPoints,
                        isCurved: true,
                        colors: [Colors.blue],
                      ),
                    ],
                  ))
                : Center(child: const Text("No data points to display")),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FishingLurePage(),
    );
  }
}

class FishingLurePage extends StatefulWidget {
  const FishingLurePage({super.key});

  @override
  State<FishingLurePage> createState() => _FishingLurePageState();
}

class _FishingLurePageState extends State<FishingLurePage> {
  final _formKey = GlobalKey<FormState>();

  String? waterClarity;
  String? timeOfDay;
  String result = "Choose your fishing conditions and get a lure recommendation!";

  final List<Color> colors = [
    Colors.white,
    Colors.lightBlue,
    Colors.green,
    Colors.orange,
    Colors.black,
  ];

  int colorIndex = 0;

  Color get currentColor => colors[colorIndex];

  Color get textColor {
    return currentColor.computeLuminance() < 0.5
        ? Colors.white
        : Colors.black;
  }

  void cycleBackground() {
    setState(() {
      colorIndex = (colorIndex + 1) % colors.length;
    });
  }

  void recommendLure() {
    if (_formKey.currentState!.validate()) {
      String lure = "";
      String lureColor = "";

      if (waterClarity == "Clear" && timeOfDay == "Morning") {
        lure = "Topwater Popper";
        lureColor = "Natural Shad";
      } else if (waterClarity == "Clear" && timeOfDay == "Afternoon") {
        lure = "Soft Plastic Worm";
        lureColor = "Green Pumpkin";
      } else if (waterClarity == "Clear" && timeOfDay == "Evening") {
        lure = "Jerkbait";
        lureColor = "Silver or White";
      } else if (waterClarity == "Stained" && timeOfDay == "Morning") {
        lure = "Spinnerbait";
        lureColor = "White and Chartreuse";
      } else if (waterClarity == "Stained" && timeOfDay == "Afternoon") {
        lure = "Crankbait";
        lureColor = "Red Craw";
      } else if (waterClarity == "Stained" && timeOfDay == "Evening") {
        lure = "Chatterbait";
        lureColor = "Black and Blue";
      } else if (waterClarity == "Muddy" && timeOfDay == "Morning") {
        lure = "Buzzbait";
        lureColor = "Black";
      } else if (waterClarity == "Muddy" && timeOfDay == "Afternoon") {
        lure = "Spinnerbait";
        lureColor = "Chartreuse";
      } else {
        lure = "Swim Jig";
        lureColor = "Black and Blue";
      }

      setState(() {
        result =
            "Recommended Lure: $lure\nRecommended Color: $lureColor\n\nConditions: $waterClarity water, $timeOfDay";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cycleBackground,
      child: Scaffold(
        backgroundColor: currentColor,
        appBar: AppBar(
          title: const Text("Fishing Lure Picker"),
          backgroundColor: currentColor,
          foregroundColor: textColor,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: currentColor,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Tap empty space to cycle the background color.",
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                DropdownButtonFormField<String>(
                  value: waterClarity,
                  decoration: const InputDecoration(
                    labelText: "Water Clarity",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  items: const [
                    DropdownMenuItem(value: "Clear", child: Text("Clear")),
                    DropdownMenuItem(value: "Stained", child: Text("Stained")),
                    DropdownMenuItem(value: "Muddy", child: Text("Muddy")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      waterClarity = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select water clarity.";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 15),

                DropdownButtonFormField<String>(
                  value: timeOfDay,
                  decoration: const InputDecoration(
                    labelText: "Time of Day",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  items: const [
                    DropdownMenuItem(value: "Morning", child: Text("Morning")),
                    DropdownMenuItem(value: "Afternoon", child: Text("Afternoon")),
                    DropdownMenuItem(value: "Evening", child: Text("Evening")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      timeOfDay = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select a time of day.";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: recommendLure,
                  icon: const Icon(Icons.set_meal),
                  label: const Text("Recommend Lure"),
                ),

                const SizedBox(height: 30),

                Text(
                  result,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
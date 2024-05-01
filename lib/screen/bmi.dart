import 'package:calculator/screen/currency_converter.dart';
import 'package:calculator/screen/main_page.dart';
import 'package:flutter/material.dart';

class bmi extends StatelessWidget {
  const bmi({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 100,
        title: const Text(
          'BMI-Calculator', // Change the title of the app bar here
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Urbanist-Bold',
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Code to display the side panel goes here
              showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: '',
                transitionDuration: Duration(milliseconds: 200),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 200,
                      color: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Code to handle BMI Calculator option goes here
                              print('BMI-Clicked'); // Close the side panel
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              'BMI Calculator',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist-Bold',
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CurrencyConverter()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              'Currency Converter',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist-Bold',
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Code to handle Calculator option goes here
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()),
                              ); // Close the side panel
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.black,
                            ),
                            child: Text(
                              'Calculator',
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Urbanist-Bold',
                                color: Colors.white70,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController weightController = TextEditingController();
  TextEditingController feetController = TextEditingController();
  TextEditingController inchesController = TextEditingController();
  String bmiResult = '';
  bool isWeightInKg = true;
  bool isHeightInCm = true;

  void calculateBMI() {
    double weight;
    double height;

    try {
      weight = double.parse(weightController.text);
      double feet = double.parse(feetController.text);
      double inches = double.parse(inchesController.text);

      if (!isWeightInKg) {
        weight = weight * 0.45359237; // Convert pounds to kilograms
      }

      if (!isHeightInCm) {
        height = feet * 30.48 +
            inches * 2.54; // Convert feet and inches to centimeters
      } else {
        height = feet; // Use the feet value as the height in centimeters
      }
    } catch (exception) {
      setState(() {
        bmiResult = "Please enter valid values for weight and height.";
      });
      return;
    }

    if (weight != null && height != null && weight > 0 && height > 0) {
      double bmi = weight /
          (height * height / 10000); // Divide by 10000 to convert cm to meters

      setState(() {
        if (bmi < 18.5) {
          bmiResult = "Underweight";
        } else if (bmi >= 18.5 && bmi < 25) {
          bmiResult = "Normal weight";
        } else if (bmi >= 25 && bmi < 30) {
          bmiResult = "Overweight";
        } else {
          bmiResult = "Obese";
        }
      });
    } else {
      setState(() {
        bmiResult = "Please enter valid values for weight and height.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Weight:',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  DropdownButton<bool>(
                    value: isWeightInKg,
                    onChanged: (newValue) {
                      setState(() {
                        isWeightInKg = newValue!;
                      });
                    },
                    dropdownColor: Colors.black,
                    items: [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text(
                          'kg',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text(
                          'lbs',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: isWeightInKg ? 'Weight (kg)' : 'Weight (lbs)',
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Height:',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  DropdownButton<bool>(
                    value: isHeightInCm,
                    onChanged: (newValue) {
                      setState(() {
                        isHeightInCm = newValue!;
                      });
                    },
                    dropdownColor: Colors.black,
                    items: [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text(
                          'cm',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text(
                          'ft/in',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              isHeightInCm
                  ? TextField(
                      controller: feetController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Height (cm)',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextField(
                            controller: feetController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Feet',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Flexible(
                          flex: 2,
                          child: TextField(
                            controller: inchesController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.white,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Inches',
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'BMI: $bmiResult',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

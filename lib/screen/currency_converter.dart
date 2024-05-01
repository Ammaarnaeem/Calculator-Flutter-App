import 'package:calculator/screen/main_page.dart';
import 'package:calculator/screen/bmi.dart';
import 'package:flutter/material.dart';

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 100,
        title: const Text(
          'Currency Converter', // Change the title of the app bar here
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
                              print("CC page"); // Close the side panel
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
                                color: Colors.white,
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
                          ElevatedButton(
                            onPressed: () {
                              // Code to handle BMI Calculator option goes here
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => bmi()),
                              ); // Close the side panel
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
      backgroundColor: Colors.black,
      body: CCScreen(),
    );
  }
}

class CCScreen extends StatefulWidget {
  @override
  _CCScreenState createState() => _CCScreenState();
}

class _CCScreenState extends State<CCScreen> {
  TextEditingController CC1Controller = TextEditingController();
  TextEditingController CC2Controller = TextEditingController();
  String bmiResult = '';
  bool isWeightInKg = true;
  bool isHeightInCm = true;
  String selectedCurrency = 'USD';

  void calculateBMI() {
    double weight;
    double height;

    try {
      weight = double.parse(CC1Controller.text);
      double feet = double.parse(CC2Controller.text);

      if (!isWeightInKg) {
        weight = weight * 0.45359237; // Convert pounds to kilograms
      }

      if (!isHeightInCm) {
        height = feet * 30.48; // Convert feet and inches to centimeters
      } else {
        height = feet; // Use the feet value as the height in centimeters
      }
    } catch (exception) {
      setState(() {
        bmiResult = "Please enter valid values for currencies.";
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
        bmiResult = "Please enter valid values for Currencies.";
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
                  const Text(
                    'Currency 1:',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  DropdownButton<bool>(
                    value: isWeightInKg,
                    onChanged: (newValue) {
                      setState(() {
                        isWeightInKg = newValue!;
                      });
                    },
                    dropdownColor: Colors.black,
                    items: const [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text(
                          'USD',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text(
                          'EURO',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: CC1Controller,
                keyboardType: TextInputType.number,
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: isWeightInKg ? 'USD' : 'EURO',
                  labelStyle: const TextStyle(
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
                    'Currency 2:',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  DropdownButton<String>(
                    value: selectedCurrency,
                    onChanged: (newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                    dropdownColor: Colors.black,
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'USD',
                        child: Text(
                          'USD',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'EURO',
                        child: Text(
                          'EURO',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Pound',
                        child: Text(
                          'Pound',
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'PKR',
                        child: Text(
                          'PKR',
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
                controller: CC2Controller,
                keyboardType: TextInputType.number,
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  labelText: selectedCurrency ?? '',
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
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Convert',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

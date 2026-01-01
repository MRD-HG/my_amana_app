import 'package:flutter/material.dart';
import 'package:my_amana_app/features/tarif/tarif_service.dart';
import 'package:my_amana_app/core/widgets/action_button.dart';

class MapAppt extends StatefulWidget {
  const MapAppt({super.key});

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapAppt> {
  bool envoiNatio = true;
  bool envioInterna = false;
  bool ecomerse = false;
  Alignment gh = Alignment.bottomCenter;
  final TarifService _tarifService = TarifService();
  final TextEditingController _nationalWeightController =
      TextEditingController();
  final TextEditingController _internationalWeightController =
      TextEditingController();
  final TextEditingController _ecommerceWeightController =
      TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double? _nationalResult;
  double? _internationalResult;
  double? _ecommerceResult;

  void _envoiNatio() {
    setState(() {
      if (envoiNatio == !true) {
        envoiNatio = !envoiNatio;
        envioInterna = false;
        ecomerse = false;
      }
    });
  }

  void _envioInterna() {
    setState(() {
      if (envioInterna == !true) {
        envioInterna = !envioInterna;
        envoiNatio = false;

        ecomerse = false;
      }
    });
  }

  void _ecomerse() {
    setState(() {
      if (ecomerse == !true) {
        ecomerse = !ecomerse;
        envoiNatio = false;

        envioInterna = false;
      }
    });
  }

  bool isPanelOpen = false;
  int selectedIdx = -1;
  int selectedOption = 1;

  @override
  void dispose() {
    _nationalWeightController.dispose();
    _internationalWeightController.dispose();
    _ecommerceWeightController.dispose();
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  double? _parsePositiveDouble(String value) {
    final parsed = double.tryParse(value.trim());
    if (parsed == null || parsed <= 0) {
      return null;
    }
    return parsed;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _calculateNational() {
    final weight = _parsePositiveDouble(_nationalWeightController.text);
    if (weight == null) {
      _showError('Saisissez un poids valide.');
      return;
    }
    setState(() {
      _nationalResult = _tarifService.calculate(
        type: TarifType.national,
        weightKg: weight,
      );
    });
  }

  void _calculateInternational() {
    final weight = _parsePositiveDouble(_internationalWeightController.text);
    if (weight == null) {
      _showError('Saisissez un poids valide.');
      return;
    }
    final length = _parsePositiveDouble(_lengthController.text);
    final width = _parsePositiveDouble(_widthController.text);
    final height = _parsePositiveDouble(_heightController.text);

    setState(() {
      _internationalResult = _tarifService.calculate(
        type: TarifType.international,
        weightKg: weight,
        lengthCm: length,
        widthCm: width,
        heightCm: height,
      );
    });
  }

  void _calculateEcommerce() {
    final weight = _parsePositiveDouble(_ecommerceWeightController.text);
    if (weight == null) {
      _showError('Saisissez un poids valide.');
      return;
    }
    setState(() {
      _ecommerceResult = _tarifService.calculate(
        type: TarifType.ecommerce,
        weightKg: weight,
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _envoiNatio,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                      textStyle: const TextStyle(fontSize: 15),
                      padding: const EdgeInsets.all(18),
                    ),
                    child: const Text('ENVOI NATIONAL'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _envioInterna,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                      textStyle: const TextStyle(fontSize: 15),
                      padding: const EdgeInsets.all(18),
                    ),
                    child: const Text('ENVOI INTERNA'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _ecomerse,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 216, 203, 183),
                      textStyle: const TextStyle(fontSize: 16),
                      padding: const EdgeInsets.all(18),
                    ),

                    child: const Text('ECOMERCE'),
                  ),
                ),
              ],
            ),
            Visibility(
                visible: envoiNatio,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Container(
                    color: const Color.fromARGB(255, 237, 236, 236),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _nationalWeightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.ltr,
                              hintText: 'Poids',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 243, 114, 33),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 0, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 123, 123, 123),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Type d'enballage"),
                                ),
                                const SizedBox(
                                  width: 185,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor: const Color.fromARGB(255, 240, 133, 26),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // Set the border radius of the button
                                      ),
                                    ),
                                    child: const Text('Sans emballage'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                ActionButton(
                                  label: 'Calculer',
                                  onPressed: _calculateNational,
                                )
                              ],
                            )),
                        if (_nationalResult != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Tarif estime: ${_nationalResult!.toStringAsFixed(2)} DH',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                )),
            Visibility(
                visible: envioInterna,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Container(
                    color: const Color.fromARGB(255, 237, 236, 236),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _internationalWeightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.ltr,
                              hintText: 'Poids',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 243, 114, 33),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 8, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: _ecomerse,
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: const Color.fromARGB(255, 111, 108, 108), backgroundColor: const Color.fromARGB(255, 237, 236, 236),
                                        textStyle: const TextStyle(fontSize: 15),
                                        padding: const EdgeInsets.only(
                                            left: 0,
                                            right: 382,
                                            top: 25,
                                            bottom: 25)),
                                    child: const Text(
                                      ' Nom pays',
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 0, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 123, 123, 123),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Row(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text("Type d'enballage"),
                                ),
                                const SizedBox(
                                  width: 185,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: const Color.fromARGB(255, 0, 0, 0), backgroundColor: const Color.fromARGB(255, 240, 133, 26),
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            5), // Set the border radius of the button
                                      ),
                                    ),
                                    child: const Text('Sans emballage'),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20, right: 5),
                              width: 150,
                              height: 50,
                              child: TextField(
                                controller: _lengthController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.ltr,
                                  hintText: 'Longeur  ',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 243, 114, 33),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 5),
                              width: 150,
                              height: 50,
                              child: TextField(
                                controller: _widthController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.ltr,
                                  hintText: 'Largeur',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 243, 114, 33),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 5),
                              width: 150,
                              height: 50,
                              child: TextField(
                                controller: _heightController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.ltr,
                                  hintText: 'Hauteur',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 243, 114, 33),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                            child: Row(
                              children: [
                                ActionButton(
                                  label: 'Calculer',
                                  onPressed: _calculateInternational,
                                )
                              ],
                            )),
                        if (_internationalResult != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Tarif estime: ${_internationalResult!.toStringAsFixed(2)} DH',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                  ),
                )),
           
                   Visibility(
              visible: ecomerse,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                child: Container(
                  color: const Color.fromARGB(255, 237, 236, 236),
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 0, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 123, 123, 123),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 50),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              Radio(
                                                  value: 'INTRAVILE',
                                                  groupValue: selectedOption,
                                                  onChanged: (val) {
                                                    setState(() {});
                                                  }),
                                              const Text('INTRAVILE'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 50, right: 10),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              Radio(
                                                  value: 'DOMICILE',
                                                  groupValue: selectedOption,
                                                  onChanged: (val) {
                                                    setState(() {
                                                    });
                                                  }),
                                              const Text('DOMICILE'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 50),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              Radio(
                                                  value: 'INTERVIL',
                                                  groupValue: selectedOption,
                                                  onChanged: (val) {
                                                    setState(() {});
                                                  }),
                                              const Text('INTERVIL'),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 53),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 20),
                                              Radio(
                                                  value: 'EN AGENCE',
                                                  groupValue: selectedOption,
                                                  onChanged: (val) {
                                                    setState(() {
                                                    });
                                                  }),
                                              const Text('EN AGENCE'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(padding:  const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                         child:  Padding(
                          padding: const EdgeInsets.all(5),
                          child: TextField(
                            controller: _ecommerceWeightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintTextDirection: TextDirection.ltr,
                              hintText: 'Poids',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 243, 114, 33),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              ActionButton(
                                label: 'Calculer',
                                onPressed: _calculateEcommerce,
                              ),
                            ],
                          ),
                        ),
                      if (_ecommerceResult != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Tarif estime: ${_ecommerceResult!.toStringAsFixed(2)} DH',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

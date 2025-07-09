import 'package:flutter/material.dart';
import 'package:phoneplus/credits/domain/bond_request.dto.dart';
import 'package:phoneplus/credits/interfaces/providers/bond_provider.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_bottom_navigation_bar.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_button.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_dialog.dart';
import 'package:phoneplus/shared/interfaces/widgets/form_text_field.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/ui/constants/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/bonds_screen.dart';

class NewPlanScreen extends StatefulWidget {
  const NewPlanScreen({super.key});

  @override
  State<NewPlanScreen> createState() => _NewPlanScreenState();
}

class _NewPlanScreenState extends State<NewPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nominalValueController = TextEditingController();
  final TextEditingController commercialValueController = TextEditingController();
  final TextEditingController structurationRateController = TextEditingController();
  final TextEditingController colonRateController = TextEditingController();
  final TextEditingController flotationRateController = TextEditingController();
  final TextEditingController cavaliRateController = TextEditingController();
  final TextEditingController primRateController = TextEditingController();
  final TextEditingController numberOfYearsController = TextEditingController();
  final TextEditingController yearDiscountController = TextEditingController();
  final TextEditingController rentImportController = TextEditingController();
  final TextEditingController cuponRateController = TextEditingController();
  final TextEditingController issueDateController = TextEditingController();

  // Enums y listas
  final List<Map<String, dynamic>> currencies = [
    {'value': 1, 'label': 'Soles'},
    {'value': 2, 'label': 'Dólares'},
    {'value': 3, 'label': 'Euros'},
  ];
  final List<Map<String, dynamic>> capitalizationTypes = [
    {'value': 1, 'label': 'Cuatrimestral'},
    {'value': 2, 'label': 'Semestral'},
    {'value': 3, 'label': 'Anual'},
    {'value': 4, 'label': 'Bimestral'},
    {'value': 5, 'label': 'Mensual'},
    {'value': 6, 'label': 'Semanal'},
    {'value': 7, 'label': 'Diario'},
  ];
  final List<Map<String, dynamic>> frequencies = [
    {'value': 1, 'label': 'Bimestral'},
    {'value': 2, 'label': 'Trimestral'},
    {'value': 3, 'label': 'Anual'},
    {'value': 4, 'label': 'Quincenal'},
    {'value': 5, 'label': 'Mensual'},
    {'value': 6, 'label': 'Cuatrimestral'},
    {'value': 7, 'label': 'Semestral'},
  ];
  final List<Map<String, dynamic>> cuponRateTypes = [
    {'value': 1, 'label': 'Tasa Efectiva'},
    {'value': 2, 'label': 'Tasa Nominal'},
    {'value': 3, 'label': 'Tasa de Descuento'},
  ];
  final List<Map<String, dynamic>> graceTypes = [
    {'value': 0, 'label': 'Ninguno'},
    {'value': 1, 'label': 'Parcial'},
    {'value': 2, 'label': 'Total'},
  ];

  int? selectedCurrency;
  int? selectedCapitalizationType;
  int? selectedFrequency;
  int? selectedCuponRateType;
  int? selectedCuponRateFrequency;
  int? selectedCuponRateCapitalization;
  List<GracePeriod> gracePeriods = [];

  int? selectedGraceType;
  final TextEditingController gracePeriodNumberController = TextEditingController();

  Future<void> _loadConfigFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final configCurrency = prefs.getString('config_currency');
    final configRateType = prefs.getString('config_rateType');
    final configCapitalization = prefs.getString('config_capitalization');
    setState(() {
      selectedCurrency = _mapCurrencyStringToValue(configCurrency ?? 'Soles');
      selectedCuponRateType = _mapRateTypeStringToValue(configRateType ?? 'Efectiva');
      selectedCapitalizationType = _mapCapitalizationStringToValue(configCapitalization ?? 'Mensual');
      selectedCuponRateCapitalization = _mapCapitalizationStringToValue(configCapitalization ?? 'Mensual');
    });
  }

  int _mapCurrencyStringToValue(String currency) {
    switch (currency) {
      case 'PEN':
      case 'Soles':
        return 1;
      case 'USD':
      case 'Dólares':
        return 2;
      case 'EUR':
      case 'Euros':
        return 3;
      default:
        return 1;
    }
  }

  int _mapRateTypeStringToValue(String rateType) {
    switch (rateType) {
      case 'Efectiva':
        return 1;
      case 'Nominal':
        return 2;
      default:
        return 1;
    }
  }

  int _mapCapitalizationStringToValue(String cap) {
    switch (cap) {
      case 'Cuatrimestral':
        return 1;
      case 'Semestral':
        return 2;
      case 'Anual':
        return 3;
      case 'Bimestral':
        return 4;
      case 'Mensual':
        return 5;
      case 'Semanal':
        return 6;
      case 'Diario':
        return 7;
      default:
        return 5;
    }
  }

  @override
  void initState() {
    super.initState();
    selectedCurrency = currencies[0]['value'] as int;
    selectedCapitalizationType = capitalizationTypes[0]['value'] as int;
    selectedFrequency = frequencies[0]['value'] as int;
    selectedCuponRateType = cuponRateTypes[0]['value'] as int;
    selectedCuponRateFrequency = frequencies[0]['value'] as int;
    selectedCuponRateCapitalization = capitalizationTypes[0]['value'] as int;
    selectedGraceType = graceTypes[0]['value'] as int;
    _loadConfigFromPrefs();
  }

  @override
  void dispose() {
    nominalValueController.dispose();
    commercialValueController.dispose();
    structurationRateController.dispose();
    colonRateController.dispose();
    flotationRateController.dispose();
    cavaliRateController.dispose();
    primRateController.dispose();
    numberOfYearsController.dispose();
    yearDiscountController.dispose();
    rentImportController.dispose();
    cuponRateController.dispose();
    issueDateController.dispose();
    gracePeriodNumberController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale('es', ''),
    );
    if (picked != null) {
      issueDateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  void _addGracePeriod() {
    if (gracePeriodNumberController.text.isNotEmpty && selectedGraceType != null) {
      setState(() {
        gracePeriods.add(GracePeriod(
          period: int.tryParse(gracePeriodNumberController.text) ?? 1,
          type: selectedGraceType!,
        ));
        gracePeriodNumberController.clear();
        selectedGraceType = graceTypes[0]['value'];
      });
    }
  }

  Future<void> _registerBond() async {
    if (_formKey.currentState?.validate() ?? false) {
      final userId = await StorageHelper.getUserId();
      final request = BondRequest(
        commercialValue: double.tryParse(commercialValueController.text),
        nominalValue: double.tryParse(nominalValueController.text),
        structurationRate: double.tryParse(structurationRateController.text),
        colonRate: double.tryParse(colonRateController.text),
        flotationRate: double.tryParse(flotationRateController.text),
        cavaliRate: double.tryParse(cavaliRateController.text),
        primRate: double.tryParse(primRateController.text),
        numberOfYears: int.tryParse(numberOfYearsController.text),
        frequencies: selectedFrequency,
        dayPerYear: 360,
        capitalizationTypes: selectedCapitalizationType,
        yearDiscount: int.tryParse(yearDiscountController.text) ?? 0,
        rentImport: double.tryParse(rentImportController.text) ?? 0,
        userId: userId,
        cuponRate: double.tryParse(cuponRateController.text),
        cuponRateType: selectedCuponRateType,
        cuponRateFrequency: selectedCuponRateFrequency,
        cuponRateCapitalization: selectedCuponRateCapitalization,
        currency: selectedCurrency,
        gracePeriods: gracePeriods,
      );
      try {
        final bondProvider = context.read<BondProvider>();
        await bondProvider.createBond(request);
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: '¡Registro exitoso!',
              content: 'El bono fue registrado correctamente.',
              isSuccess: true,
              onConfirm: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => BondsScreen()),
                );
              },
              onCancel: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => BondsScreen()),
                );
              },
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: '¡Ocurrió un error!',
              content: 'No se pudo registrar el bono. Intente nuevamente.',
              isSuccess: false,
              onConfirm: () => Navigator.pop(context),
              onCancel: () => Navigator.pop(context),
            ),
          );
        }
      }
    }
  }

  void _cleanFields() {
    nominalValueController.clear();
    commercialValueController.clear();
    structurationRateController.clear();
    colonRateController.clear();
    flotationRateController.clear();
    cavaliRateController.clear();
    primRateController.clear();
    numberOfYearsController.clear();
    yearDiscountController.clear();
    rentImportController.clear();
    cuponRateController.clear();
    issueDateController.clear();
    gracePeriodNumberController.clear();
    setState(() {
      selectedCurrency = currencies[0]['value'];
      selectedCapitalizationType = capitalizationTypes[0]['value'];
      selectedFrequency = frequencies[0]['value'];
      selectedCuponRateType = cuponRateTypes[0]['value'];
      selectedCuponRateFrequency = frequencies[0]['value'];
      selectedCuponRateCapitalization = capitalizationTypes[0]['value'];
      selectedGraceType = graceTypes[0]['value'];
      gracePeriods.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 70),
          child: Column(
            children: [
              SizedBox(
                width: 170,
                child: Text(
                  "Nuevo Bono",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: text,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    FormTextField(
                      label: 'Valor nominal',
                      hintText: 'Ingrese el valor nominal',
                      controller: nominalValueController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Valor comercial',
                      hintText: 'Ingrese el valor comercial',
                      controller: commercialValueController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Tasa de estructuración (%)',
                      hintText: 'Ingrese la tasa de estructuración',
                      controller: structurationRateController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Tasa de colocación (%)',
                      hintText: 'Ingrese la tasa de colocación',
                      controller: colonRateController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Tasa de flotación (%)',
                      hintText: 'Ingrese la tasa de flotación',
                      controller: flotationRateController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Tasa Cavali (%)',
                      hintText: 'Ingrese la tasa Cavali',
                      controller: cavaliRateController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Prima de redención (%)',
                      hintText: 'Ingrese la prima de redención',
                      controller: primRateController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Número de años',
                      hintText: 'Ingrese el número de años',
                      controller: numberOfYearsController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Descuento anual (%)',
                      hintText: 'Ingrese el descuento anual',
                      controller: yearDiscountController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Importe de renta',
                      hintText: 'Ingrese el importe de renta',
                      controller: rentImportController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Tasa cupón (%)',
                      hintText: 'Ingrese la tasa cupón',
                      controller: cuponRateController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Fecha de emisión',
                      hintText: 'Seleccione la fecha',
                      controller: issueDateController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 20),
                    // Dropdowns
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DropdownButtonFormField<int>(
                        value: currencies.any((e) => e['value'] == selectedCurrency) ? selectedCurrency : currencies[0]['value'],
                        items: currencies.map((e) => DropdownMenuItem<int>(value: e['value'] as int, child: Text(e['label'] as String, style: TextStyle(color: Colors.black)))).toList(),
                        onChanged: (v) => setState(() => selectedCurrency = v),
                        decoration: const InputDecoration(labelText: 'Moneda'),
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DropdownButtonFormField<int>(
                        value: capitalizationTypes.any((e) => e['value'] == selectedCapitalizationType) ? selectedCapitalizationType : capitalizationTypes[0]['value'],
                        items: capitalizationTypes.map((e) => DropdownMenuItem<int>(value: e['value'] as int, child: Text(e['label'] as String,style: TextStyle(color: Colors.black)))).toList(),
                        onChanged: (v) => setState(() => selectedCapitalizationType = v),
                        decoration: const InputDecoration(labelText: 'Capitalización'),
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DropdownButtonFormField<int>(
                        value: frequencies.any((e) => e['value'] == selectedFrequency) ? selectedFrequency : frequencies[0]['value'],
                        items: frequencies.map((e) => DropdownMenuItem<int>(value: e['value'] as int, child: Text(e['label'] as String, style: TextStyle(color: Colors.black)))).toList(),
                        onChanged: (v) => setState(() => selectedFrequency = v),
                        decoration: const InputDecoration(labelText: 'Frecuencia'),
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DropdownButtonFormField<int>(
                        value: cuponRateTypes.any((e) => e['value'] == selectedCuponRateType) ? selectedCuponRateType : cuponRateTypes[0]['value'],
                        items: cuponRateTypes.map((e) => DropdownMenuItem<int>(value: e['value'] as int, child: Text(e['label'] as String, style: TextStyle(color: Colors.black),))).toList(),
                        onChanged: (v) => setState(() => selectedCuponRateType = v),
                        decoration: const InputDecoration(labelText: 'Tipo de Tasa de Cupón'),
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DropdownButtonFormField<int>(
                        value: frequencies.any((e) => e['value'] == selectedCuponRateFrequency) ? selectedCuponRateFrequency : frequencies[0]['value'],
                        items: frequencies.map((e) => DropdownMenuItem<int>(value: e['value'] as int, child: Text(e['label'] as String, style: TextStyle(color: Colors.black)))).toList(),
                        onChanged: (v) => setState(() => selectedCuponRateFrequency = v),
                        decoration: const InputDecoration(labelText: 'Frecuencia de Cupón'),
                        isExpanded: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: DropdownButtonFormField<int>(
                        value: capitalizationTypes.any((e) => e['value'] == selectedCuponRateCapitalization) ? selectedCuponRateCapitalization : capitalizationTypes[0]['value'],
                        items: capitalizationTypes.map((e) => DropdownMenuItem<int>(value: e['value'] as int, child: Text(e['label'] as String, style: TextStyle(color: Colors.black)))).toList(),
                        onChanged: (v) => setState(() => selectedCuponRateCapitalization = v),
                        decoration: const InputDecoration(labelText: 'Capitalización de Cupón'),
                        isExpanded: true,
                      ),
                    ),
                    // Campos para periodos de gracia
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: gracePeriodNumberController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(labelText: 'Periodo de gracia' ),style: TextStyle(color: Colors.black)
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              value: graceTypes.any((e) => e['value'] == selectedGraceType) ? selectedGraceType : graceTypes[0]['value'],
                              items: graceTypes.map((e) => DropdownMenuItem<int>(value: e['value'] as int, child: Text(e['label'] as String, style: TextStyle(color: Colors.black)))).toList(),
                              onChanged: (v) => setState(() => selectedGraceType = v),
                              decoration: const InputDecoration(labelText: 'Tipo de gracia'),
                              isExpanded: true,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: _addGracePeriod,
                          ),
                        ],
                      ),
                    ),
                    if (gracePeriods.isNotEmpty)
                      Column(
                        children: gracePeriods.map((gp) => ListTile(
                          title: Text('Periodo: ${gp.period}, Tipo: ${graceTypes.firstWhere((e) => e['value'] == gp.type)['label']}'),
                        )).toList(),
                      ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            label: "Limpiar",
                            onPressed: _cleanFields,
                            isStrong: false,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomButton(
                            label: "Registrar",
                            onPressed: _registerBond,
                            isStrong: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

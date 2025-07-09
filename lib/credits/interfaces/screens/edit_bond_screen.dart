import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helpers/date_time_helper.dart';
import '../../../shared/infraestructure/helpers/storage_helper.dart';
import '../../../shared/interfaces/widgets/custom_button.dart';
import '../../../shared/interfaces/widgets/custom_dialog.dart';
import '../../../shared/interfaces/widgets/form_text_field.dart';
import '../../../ui/constants/constant.dart';
import '../../domain/bond_request.dto.dart';
import '../../domain/bond_response.dto.dart';
import '../providers/bond_provider.dart';

class EditBondScreen extends StatefulWidget {
  final BondResponseDto bond;
  const EditBondScreen({super.key, required this.bond});

  @override
  State<EditBondScreen> createState() => _EditBondScreenState();
}

class _EditBondScreenState extends State<EditBondScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nominalValueController;
  late TextEditingController commercialValueController;
  late TextEditingController couponRateController;
  late TextEditingController marketRateController;
  late TextEditingController periodsController;
  late TextEditingController currencyController;
  late TextEditingController rateTypeController;
  late TextEditingController capitalizationController;
  late TextEditingController structuringFeeController;
  late TextEditingController placementFeeController;
  late TextEditingController flotationFeeController;
  late TextEditingController cavaliFeeController;
  late TextEditingController redemptionPremiumController;
  late TextEditingController gracePeriodsController;

  // Dropdown lists
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
  final List<Map<String, dynamic>> cuponRateTypes = [
    {'value': 1, 'label': 'Tasa Efectiva'},
    {'value': 2, 'label': 'Tasa Nominal'},
    {'value': 3, 'label': 'Tasa de Descuento'},
  ];
  int? selectedCurrency;
  int? selectedCapitalizationType;
  int? selectedCuponRateType;

  List<GracePeriod> gracePeriods = [];
  int? selectedGraceType;
  final TextEditingController gracePeriodNumberController = TextEditingController();

  Future<void> _loadConfigFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final configCurrency = prefs.getString('config_currency');
    final configRateType = prefs.getString('config_rateType');
    final configCapitalization = prefs.getString('config_capitalization');
    setState(() {
      if (widget.bond.currency != null && widget.bond.currency is String) {
        selectedCurrency = _mapCurrencyStringToValue(widget.bond.currency!);
      } else if (configCurrency != null) {
        selectedCurrency = _mapCurrencyStringToValue(configCurrency);
      } else {
        selectedCurrency = currencies[0]['value'];
      }
      if (widget.bond.rateType != null && widget.bond.rateType is String) {
        selectedCuponRateType = _mapRateTypeStringToValue(widget.bond.rateType!);
      } else if (configRateType != null) {
        selectedCuponRateType = _mapRateTypeStringToValue(configRateType);
      } else {
        selectedCuponRateType = cuponRateTypes[0]['value'];
      }
      if (widget.bond.capitalization != null && widget.bond.capitalization is String) {
        selectedCapitalizationType = _mapCapitalizationStringToValue(widget.bond.capitalization!);
      } else if (configCapitalization != null) {
        selectedCapitalizationType = _mapCapitalizationStringToValue(configCapitalization);
      } else {
        selectedCapitalizationType = capitalizationTypes[0]['value'];
      }
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
    final b = widget.bond;
    nominalValueController = TextEditingController(text: b.nominalValue?.toString() ?? '');
    commercialValueController = TextEditingController(text: b.commercialValue?.toString() ?? '');
    couponRateController = TextEditingController(text: b.couponRate?.toString() ?? '');
    marketRateController = TextEditingController(text: b.marketRate?.toString() ?? '');
    periodsController = TextEditingController(text: b.periods?.toString() ?? '');
    structuringFeeController = TextEditingController(text: b.structuringFee?.toString() ?? '');
    placementFeeController = TextEditingController(text: b.placementFee?.toString() ?? '');
    flotationFeeController = TextEditingController(text: b.flotationFee?.toString() ?? '');
    cavaliFeeController = TextEditingController(text: b.cavaliFee?.toString() ?? '');
    redemptionPremiumController = TextEditingController(text: b.redemptionPremium?.toString() ?? '');
    gracePeriodsController = TextEditingController();
    currencyController = TextEditingController();
    rateTypeController = TextEditingController();
    capitalizationController = TextEditingController();
    _loadConfigFromPrefs();
    selectedGraceType = 0;
    // Si el bono tiene periodos de gracia, inicializarlos
    // (esto depende de cómo se almacenen en BondResponseDto)
  }

  void _addGracePeriod() {
    if (gracePeriodNumberController.text.isNotEmpty && selectedGraceType != null) {
      setState(() {
        gracePeriods.add(GracePeriod(
          period: int.tryParse(gracePeriodNumberController.text) ?? 1,
          type: selectedGraceType!,
        ));
        gracePeriodNumberController.clear();
        selectedGraceType = 0;
      });
    }
  }

  @override
  void dispose() {
    nominalValueController.dispose();
    commercialValueController.dispose();
    couponRateController.dispose();
    marketRateController.dispose();
    periodsController.dispose();
    currencyController.dispose();
    rateTypeController.dispose();
    capitalizationController.dispose();
    structuringFeeController.dispose();
    placementFeeController.dispose();
    flotationFeeController.dispose();
    cavaliFeeController.dispose();
    redemptionPremiumController.dispose();
    gracePeriodsController.dispose();
    gracePeriodNumberController.dispose();
    super.dispose();
  }

  Future<void> _editBond() async {
    if (_formKey.currentState?.validate() ?? false) {
      final bondProvider = context.read<BondProvider>();
      int? userId = widget.bond.userId;
      if (userId == null) {
        userId = await StorageHelper.getUserId();
      }
      final request = BondRequest(
        id: widget.bond.id,
        commercialValue: double.tryParse(commercialValueController.text),
        nominalValue: double.tryParse(nominalValueController.text),
        structurationRate: double.tryParse(structuringFeeController.text),
        colonRate: double.tryParse(placementFeeController.text),
        flotationRate: double.tryParse(flotationFeeController.text),
        cavaliRate: double.tryParse(cavaliFeeController.text),
        primRate: double.tryParse(redemptionPremiumController.text),
        numberOfYears: int.tryParse(periodsController.text),
        frequencies: 1, // Puedes agregar un dropdown si lo necesitas
        dayPerYear: 360,
        capitalizationTypes: selectedCapitalizationType,
        userId: userId,
        cuponRate: double.tryParse(couponRateController.text),
        cuponRateType: selectedCuponRateType,
        cuponRateFrequency: 1, // Puedes agregar un dropdown si lo necesitas
        cuponRateCapitalization: selectedCapitalizationType,
        currency: selectedCurrency,
        gracePeriods: gracePeriods.isNotEmpty ? gracePeriods : [GracePeriod(period: 0, type: 0)],
      );
      print('Request PATCH BONO: ' + request.toRequest().toString());
      try {
        await bondProvider.updateBond(widget.bond.id!, request);
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: '¡Edición exitosa!',
              content: 'El bono fue editado correctamente.',
              isSuccess: true,
              onConfirm: () {
                Navigator.pop(context); // Cierra el diálogo
                Navigator.pop(context); // Vuelve a la lista de bonos
              },
              onCancel: () {
                Navigator.pop(context); // Cierra el diálogo
                Navigator.pop(context); // Vuelve a la lista de bonos
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
              content: 'No se pudo editar el bono. Intente nuevamente.',
              isSuccess: false,
              onConfirm: () => Navigator.pop(context),
              onCancel: () => Navigator.pop(context),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Bono'), backgroundColor: primary),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 70),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: DefaultTextStyle(
            style: const TextStyle(color: Colors.black), // Fuerza texto negro por defecto
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  FormTextField(label: 'Valor nominal', hintText: '', controller: nominalValueController, keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  FormTextField(label: 'Valor comercial', hintText: '', controller: commercialValueController, keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  FormTextField(label: 'Tasa cupón (%)', hintText: '', controller: couponRateController, keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  FormTextField(label: 'Tasa de mercado (%)', hintText: '', controller: marketRateController, keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  FormTextField(label: 'Plazo (periodos)', hintText: '', controller: periodsController, keyboardType: TextInputType.number),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: selectedCurrency,
                    items: currencies.map((e) => DropdownMenuItem<int>(value: e['value'], child: Text(e['label'], style: TextStyle(color: Colors.black)))).toList(),
                    onChanged: (v) => setState(() => selectedCurrency = v),
                    decoration: const InputDecoration(labelText: 'Moneda'),
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                    isExpanded: true,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: selectedCuponRateType,
                    items: cuponRateTypes.map((e) => DropdownMenuItem<int>(value: e['value'], child: Text(e['label'], style: TextStyle(color: Colors.black)))).toList(),
                    onChanged: (v) => setState(() => selectedCuponRateType = v),
                    decoration: const InputDecoration(labelText: 'Tipo de Tasa'),
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                    isExpanded: true,
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: selectedCapitalizationType,
                    items: capitalizationTypes.map((e) => DropdownMenuItem<int>(value: e['value'], child: Text(e['label'], style: TextStyle(color: Colors.black)))).toList(),
                    onChanged: (v) => setState(() => selectedCapitalizationType = v),
                    decoration: const InputDecoration(labelText: 'Capitalización'),
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black),
                    isExpanded: true,
                  ),
                  const SizedBox(height: 20),
                  // Periodos de gracia
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: gracePeriodNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Periodo de gracia'),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: selectedGraceType,
                          items: [
                            {'value': 0, 'label': 'Ninguno'},
                            {'value': 1, 'label': 'Parcial'},
                            {'value': 2, 'label': 'Total'},
                          ].map((e) => DropdownMenuItem<int>(value: e['value'] as int, child: Text(e['label'] as String, style: TextStyle(color: Colors.black)))).toList(),
                          onChanged: (int? v) => setState(() => selectedGraceType = v),
                          decoration: const InputDecoration(labelText: 'Tipo de gracia'),
                          dropdownColor: Colors.white,
                          style: const TextStyle(color: Colors.black),
                          isExpanded: true,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _addGracePeriod,
                      ),
                    ],
                  ),
                  if (gracePeriods.isNotEmpty)
                    Column(
                      children: gracePeriods.map((gp) => ListTile(
                        title: Text('Periodo: ${gp.period}, Tipo: ${gp.type}'),
                      )).toList(),
                    ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      label: 'Guardar Cambios',
                      onPressed: _editBond,
                      isStrong: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

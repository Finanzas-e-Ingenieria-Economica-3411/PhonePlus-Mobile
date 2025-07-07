import 'package:flutter/material.dart';
import 'package:phoneplus/credits/domain/bond_request.dto.dart';
import 'package:phoneplus/credits/interfaces/providers/bond_provider.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_button.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_dialog.dart';
import 'package:phoneplus/shared/interfaces/widgets/form_text_field.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/ui/constants/constant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPlanScreen extends StatefulWidget {
  const NewPlanScreen({super.key});

  @override
  State<NewPlanScreen> createState() => _NewPlanScreenState();
}

class _NewPlanScreenState extends State<NewPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nominalValueController = TextEditingController();
  final TextEditingController commercialValueController = TextEditingController();
  final TextEditingController couponRateController = TextEditingController();
  final TextEditingController marketRateController = TextEditingController();
  final TextEditingController periodsController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController rateTypeController = TextEditingController();
  final TextEditingController capitalizationController = TextEditingController();
  final TextEditingController structuringFeeController = TextEditingController();
  final TextEditingController placementFeeController = TextEditingController();
  final TextEditingController flotationFeeController = TextEditingController();
  final TextEditingController cavaliFeeController = TextEditingController();
  final TextEditingController redemptionPremiumController = TextEditingController();
  final TextEditingController gracePeriodsController = TextEditingController();
  final TextEditingController issueDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadConfigToFields();
  }

  Future<void> _loadConfigToFields() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currencyController.text = prefs.getString('config_currency') ?? '';
      rateTypeController.text = prefs.getString('config_rateType') ?? '';
      capitalizationController.text = prefs.getString('config_capitalization') ?? '';
    });
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
    issueDateController.dispose();
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

  Future<void> _registerBond() async {
    if (_formKey.currentState?.validate() ?? false) {
      final userId = await StorageHelper.getUserId();
      final request = BondRequest(
        nominalValue: double.tryParse(nominalValueController.text),
        commercialValue: double.tryParse(commercialValueController.text),
        couponRate: double.tryParse(couponRateController.text),
        marketRate: double.tryParse(marketRateController.text),
        periods: int.tryParse(periodsController.text),
        currency: currencyController.text,
        rateType: rateTypeController.text,
        capitalization: capitalizationController.text,
        structuringFee: double.tryParse(structuringFeeController.text),
        placementFee: double.tryParse(placementFeeController.text),
        flotationFee: double.tryParse(flotationFeeController.text),
        cavaliFee: double.tryParse(cavaliFeeController.text),
        redemptionPremium: double.tryParse(redemptionPremiumController.text),
        gracePeriods: int.tryParse(gracePeriodsController.text),
        issueDate: _parseDateToIso(issueDateController.text),
        userId: userId,
        state: 'active',
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
              onConfirm: () => Navigator.pop(context),
              onCancel: () => Navigator.pop(context),
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

  String? _parseDateToIso(String date) {
    try {
      final parts = date.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day).toIso8601String();
      }
    } catch (_) {}
    return null;
  }

  void _cleanFields() {
    setState(() {
      nominalValueController.clear();
      commercialValueController.clear();
      couponRateController.clear();
      marketRateController.clear();
      periodsController.clear();
      currencyController.clear();
      rateTypeController.clear();
      capitalizationController.clear();
      structuringFeeController.clear();
      placementFeeController.clear();
      flotationFeeController.clear();
      cavaliFeeController.clear();
      redemptionPremiumController.clear();
      gracePeriodsController.clear();
      issueDateController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 70),
          padding: const EdgeInsets.symmetric(horizontal: 40),
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
                      label: 'Tasa cupón (%)',
                      hintText: 'Ingrese la tasa cupón',
                      controller: couponRateController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Tasa de mercado (%)',
                      hintText: 'Ingrese la tasa de mercado',
                      controller: marketRateController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Plazo (periodos)',
                      hintText: 'Ingrese el plazo',
                      controller: periodsController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Moneda',
                      hintText: 'Ingrese la moneda',
                      controller: currencyController,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Tipo de tasa',
                      hintText: 'Efectiva/Nominal',
                      controller: rateTypeController,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Capitalización',
                      hintText: 'Ingrese la capitalización',
                      controller: capitalizationController,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Gasto de estructuración (%)',
                      hintText: 'Ingrese el gasto de estructuración',
                      controller: structuringFeeController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Gasto de colocación (%)',
                      hintText: 'Ingrese el gasto de colocación',
                      controller: placementFeeController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Gasto de flotación (%)',
                      hintText: 'Ingrese el gasto de flotación',
                      controller: flotationFeeController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Gasto Cavali (%)',
                      hintText: 'Ingrese el gasto Cavali',
                      controller: cavaliFeeController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Prima de redención (%)',
                      hintText: 'Ingrese la prima de redención',
                      controller: redemptionPremiumController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Plazos de gracia',
                      hintText: 'Ingrese los plazos de gracia',
                      controller: gracePeriodsController,
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

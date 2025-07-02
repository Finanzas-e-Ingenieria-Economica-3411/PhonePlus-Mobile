import 'package:flutter/material.dart';
import 'package:phoneplus/credits/domain/credit_request.dto.dart';
import 'package:phoneplus/credits/infrastructure/service/credit.service.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_button.dart';
import 'package:phoneplus/shared/interfaces/widgets/custom_dialog.dart';
import 'package:phoneplus/shared/interfaces/widgets/form_text_field.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/ui/constants/constant.dart';
import 'package:provider/provider.dart';
import 'package:phoneplus/credits/interfaces/providers/credit_provider.dart';

class NewPlanScreen extends StatefulWidget {
  const NewPlanScreen({super.key});

  @override
  State<NewPlanScreen> createState() => _NewPlanScreenState();
}

class _NewPlanScreenState extends State<NewPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController montoController = TextEditingController();
  final TextEditingController cuotaController = TextEditingController();
  final TextEditingController plazoController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController interesController = TextEditingController();
  final TextEditingController seguroController = TextEditingController();
  final TextEditingController periodoController = TextEditingController();
  final TextEditingController amortizationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();


  @override
  void dispose() {
    phoneNumberController.dispose();
    montoController.dispose();
    cuotaController.dispose();
    plazoController.dispose();
    fechaController.dispose();
    interesController.dispose();
    seguroController.dispose();
    periodoController.dispose();
    amortizationController.dispose();
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
      fechaController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }

  Future<void> _consultarCredito() async {
    if (_formKey.currentState?.validate() ?? false) {
      final userId = await StorageHelper.getUserId();
      final request = CreditRequest(
        phoneNumber: int.tryParse(phoneNumberController.text),
        price: double.tryParse(montoController.text),
        startDate: _parseDateToIso(fechaController.text),
        months: int.tryParse(plazoController.text),
        interestRate: double.tryParse(interesController.text),
        insurance: int.tryParse(seguroController.text),
        amortization: int.tryParse(amortizationController.text),
        paid: 0,
        interest: 0,
        pendingPayment: 0,
        userId: userId,
      );
      try {
        final creditProvider = context.read<CreditProvider>();
        await creditProvider.createCredit(request);
        if (mounted) {
          await showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: '¡Consulta exitosa!',
              content: 'El crédito fue registrado correctamente.',
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
              content: 'No se pudo registrar el crédito. Intente nuevamente.',
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
      phoneNumberController.clear();
      montoController.clear();
      cuotaController.clear();
      plazoController.clear();
      fechaController.clear();
      interesController.clear();
      seguroController.clear();
      periodoController.clear();
      amortizationController.clear();
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
                  "Nuevo",
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
                      label: 'Número de celular',
                      hintText: 'Ingrese el número de celular',
                      controller: phoneNumberController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Monto (S/)',
                      hintText: 'Ingrese el monto',
                      controller: montoController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Cuota inicial %',
                      hintText: 'Ingrese la cuota inicial',
                      controller: cuotaController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Plazo (meses)',
                      hintText: 'Ingrese el plazo',
                      controller: plazoController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Fecha de inicio',
                      hintText: 'Seleccione la fecha',
                      controller: fechaController,
                      readOnly: true,
                      onTap: () => _selectDate(context),
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Tasa de interés (%)',
                      hintText: 'Ingrese la tasa de interés',
                      controller: interesController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Seguro de desgravamen',
                      hintText: 'Ingrese el seguro',
                      controller: seguroController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Periodo de gracia (meses)',
                      hintText: 'Ingrese el periodo de gracia',
                      controller: periodoController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    FormTextField(
                      label: 'Amortización',
                      hintText: 'Ingrese la amortización',
                      controller: amortizationController,
                      keyboardType: TextInputType.number,
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
                            label: "Consultar",
                            onPressed: _consultarCredito,
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

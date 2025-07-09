import 'package:flutter/material.dart';
import 'package:phoneplus/core/helpers/date_time_helper.dart';
import 'package:phoneplus/credits/domain/bond_response.dto.dart';
import 'package:phoneplus/credits/interfaces/screens/new_plan_screen.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/shared/interfaces/widgets/form_text_field.dart';
import 'package:phoneplus/ui/constants/constant.dart';
import 'package:provider/provider.dart' show Provider, ReadContext, WatchContext;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/payment_plan.dto.dart';
import '../providers/bond_provider.dart';
import 'edit_bond_screen.dart';

class DetailsScreen extends StatefulWidget {
  final BondResponseDto bondResponseDto;
  const DetailsScreen({super.key, required this.bondResponseDto});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isMine = false;
  String role = "";
  late TextEditingController cokController;
  bool _isLoaded = false;

  String? selectedCurrency;
  String? selectedRateType;
  String? selectedCapitalization;
  String? selectedFrequency;
  PaymentPlanDto? plan;
  final List<String> rateTypes = ['Efectiva', 'Nominal', "Descuento"];
  final List<String> capitalizations = [ 'Cuatrimestral',
    'Semestral',
    'Anual',
    'Bimestral',
    'Mensual',
    'Semanal',
    'Diario'];

  final Map<String, int> frequencyDescriptionToValue = {
    'Bimestral': 1,
    'Trimestral': 2,
    'Anual': 3,
    'Quincenal': 4,
    'Mensual': 5,
    'Cuatrimestral': 6,
    'Semestral': 7,
  };


  final List<String> frequencies= [
    'Bimestral',
    'Trimestral',
    'Anual',
    'Quincenal',
    'Mensual',
    'Cuatrimestral',
    'Semestral',
  ];


  Map<String, int> rates = {
     "Efectiva": 1,
     "Nominal": 2,
    "Descuento": 3
  };

  Map<String,int> capitalizationTypesMap = {
    'Cuatrimestral': 1,
    'Semestral':2,
    'Anual':3,
    'Bimestral':4,
    'Mensual':5,
    'Semanal':6,
    'Diario':7,
  };




  Future<void> _loadConfig() async {
    setState(() {
      selectedRateType = rateTypes[0];
      selectedCapitalization = capitalizations[0];
      selectedFrequency = frequencies[0];
    });
  }

  Future<void> calculatePaymentPlan(BuildContext context) async {
    if (cokController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa el costo de oportunidad (COK)')),
      );
      return;
    }

    final bondProvider = context.read<BondProvider>();
    final cokType = rates[selectedRateType];
    final cokFrequency = frequencyDescriptionToValue[selectedFrequency];
    final cokCapitalization = capitalizationTypesMap[selectedCapitalization];

    if (cokType == null || cokFrequency == null || cokCapitalization == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error en la configuración seleccionada')),
      );
      return;
    }

    try {
      await bondProvider.calculatePaymentPlan(
          widget.bondResponseDto.id!,
          double.parse(cokController.text),
          cokType,
          cokFrequency,
          cokCapitalization
      );

      if (mounted) {
        setState(() {
          plan = bondProvider.paymentPlans;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al calcular el plan: $e')),
        );
      }
    }
  }

  @override
  void initState(){
    super.initState();
     cokController = TextEditingController();
    _loadConfig();
  }

  @override
  void dispose(){
    super.dispose();
    cokController.dispose();
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    if (!_isLoaded) {
      _isLoaded = true;
      ()async{
        final userId = await StorageHelper.getUserId();
        final result = userId == widget.bondResponseDto.userId ? true : false;
        final currentRole = await StorageHelper.getRole();
        setState(() {
          role = currentRole!;
        });
        if (role == "Emisor"){
          // Usar valores por defecto para el cálculo inicial
          final cokType = 0;
          final cokFrequency = 0;
          final cokCapitalization = 0;
          await Provider.of<BondProvider>(context,listen:false).calculatePaymentPlan(
            widget.bondResponseDto.id!,
            0,
            cokType,
            cokFrequency,
            cokCapitalization
          );
          if (mounted) {
            setState(() {
              plan = Provider.of<BondProvider>(context, listen: false).paymentPlans;
            });
          }
        }
        setState(() {
          isMine = result;
        });
      }();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bondProvider = context.watch<BondProvider>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Detalles',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A7C59),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A7C59),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Bono de ${widget.bondResponseDto.issuerName ?? "-"}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.bondResponseDto.username ?? "-",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Valor nominal: ${widget.bondResponseDto.nominalValue ?? "-"}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (role == "Inversionista")
                 Padding(
                   padding: const EdgeInsets.all(20),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       FormTextField(
                           label: "Costo de Oportunidad (COK)",
                           hintText: "Ingresa el COK",
                           controller: cokController
                       ),
                     const SizedBox(height: 24),
                     const Text('Tipo de tasa de interés', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                     DropdownButton<String>(
                       value: selectedRateType,
                       dropdownColor: Colors.white,
                       style: const TextStyle(color: Colors.black, fontSize: 16),
                       iconEnabledColor: Colors.black,
                       items: rateTypes.map((e) => DropdownMenuItem(
                         value: e,
                         child: Text(e, style: const TextStyle(color: Colors.black)),
                       )).toList(),
                       onChanged: (value) => setState(() => selectedRateType = value),
                     ),
                     const SizedBox(height: 24),
                     const Text('Capitalización', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    DropdownButton<String>(
                    value: selectedCapitalization,
                    dropdownColor: Colors.white,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    iconEnabledColor: Colors.black,
                    items: capitalizations.map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: const TextStyle(color: Colors.black)),)).toList(),
                    onChanged: (value) =>
                        setState(() =>
                        selectedCapitalization = value),
                        ),
                       const SizedBox(height: 24),
                       const Text('Frequencia', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                       DropdownButton<String>(
                         value: selectedFrequency,
                         dropdownColor: Colors.white,
                         style: const TextStyle(color: Colors.black, fontSize: 16),
                         iconEnabledColor: Colors.black,
                         items: frequencies.map((e) => DropdownMenuItem(
                           value: e,
                           child: Text(e,
                               style: const TextStyle(color: Colors.black)),)).toList(),
                         onChanged: (value) =>
                             setState(() =>
                             selectedFrequency = value),
                       ),
                       const SizedBox(height: 24),
                       SizedBox(
                         width: double.infinity,
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             backgroundColor: primary,
                             foregroundColor: background,
                             padding: const EdgeInsets.symmetric(vertical: 16),
                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                           ),
                           onPressed: () async{
                             await calculatePaymentPlan(context);
                           },
                           child: const Text('Calcular plan de pago', style: TextStyle(fontSize: 18)),
                         ),
                       ),
                     ],
                   ),
                 ),
              // Details Info
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Nombre:', 'Bono de ${widget.bondResponseDto.issuerName ?? "-"}'),
                    const SizedBox(height: 12),
                    _buildDetailRow('Valor nominal:', '${widget.bondResponseDto.nominalValue ?? "-"}'),
                    const SizedBox(height: 12),
                    _buildDetailRow('Valor comercial:', '${widget.bondResponseDto.commercialValue ?? "-"}'),
                    const SizedBox(height: 12),
                    _buildDetailRow('Tasa cupón:', '${widget.bondResponseDto.couponRate ?? "-"}'),
                    const SizedBox(height: 12),
                    _buildDetailRow('N° de operación:', widget.bondResponseDto.id?.toString() ?? "-"),
                    const SizedBox(height: 12),
                    _buildDetailRowWithInfo('TCEA:', plan != null ? plan?.tcea?.toStringAsFixed(4) ?? "-" : "-", 'Tasa de Costo Efectivo Anual (emisor): mide el costo total anual del bono para el emisor.'),
                    const SizedBox(height: 12),
                    _buildDetailRowWithInfo('TREA:', plan != null ? plan?.trea?.toStringAsFixed(4) ?? "-" :"-", 'Tasa de Rendimiento Efectivo Anual (bonista): mide el rendimiento anual real para el inversionista.'),
                    const SizedBox(height: 12),
                    _buildDetailRowWithInfo('Duración:',plan != null ? plan?.duration?.toStringAsFixed(4) ?? "-" :"-", 'Duración: mide el plazo promedio ponderado de los flujos de caja del bono.'),
                    const SizedBox(height: 12),
                    _buildDetailRowWithInfo('Duración Modificada:', plan != null && plan?.modifiedDuration != null ? plan!.modifiedDuration!.toStringAsFixed(4) : "-", 'Duración modificada: mide la sensibilidad del precio del bono ante cambios en la tasa de interés.'),
                    const SizedBox(height: 12),
                    _buildDetailRowWithInfo('Convexidad:', plan != null ? plan?.convexity?.toStringAsFixed(4) ?? "-":"-", 'Convexidad: mide la curvatura de la relación precio-tasa de interés del bono.'),
                    const SizedBox(height: 12),
                    _buildDetailRowWithInfo('Precio Máximo:',plan != null ? plan?.maxMarketPrice?.toStringAsFixed(2) ?? "-":"-", 'Precio máximo: precio máximo que el inversionista debería pagar para que el bono sea rentable.'),
                    const SizedBox(height: 20),

                    // Cash Flow Table
                    if (plan != null && plan!.cashFlows!.isNotEmpty)
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A7C59),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Table(
                          children: [
                            const TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '#Periodo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Flujo',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...plan!.cashFlows!.asMap().entries.map((entry) {
                              final i = entry.key;
                              final value = entry.value;
                              return TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${i + 1}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(value.toString(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    role == "Emisor" ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A7C59),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditBondScreen(bond: widget.bondResponseDto),
                              ),
                            );
                          },
                          child: const Text('Editar Bono', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRowWithInfo(String label, String value, String info) {
    return Builder(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: background,
                      title: Text(
                          label,
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                      content: Text(
                          info,
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Icon(Icons.info_outline, size: 18, color: Colors.blueGrey),
              ),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

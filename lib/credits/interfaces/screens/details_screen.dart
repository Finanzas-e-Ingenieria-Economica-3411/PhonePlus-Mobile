import 'package:flutter/material.dart';
import 'package:phoneplus/core/helpers/date_time_helper.dart';
import 'package:phoneplus/credits/domain/bond_response.dto.dart';
import 'package:phoneplus/credits/interfaces/screens/new_plan_screen.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/ui/constants/constant.dart';
import 'package:provider/provider.dart' show Provider, WatchContext;

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
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    ()async{
      final userId = await StorageHelper.getUserId();
      final result = userId == widget.bondResponseDto.userId ? true : false;
      final currentRole = await StorageHelper.getRole();
      setState(() {
        role = currentRole!;
      });
      if (currentRole == "Emisor"){
        Future.microtask(() => Provider.of<BondProvider>(context,listen:false).calculatePaymentPlan(widget.bondResponseDto.id!,0,0,0,0));
      }
      setState(() {
        isMine = result;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    final bondProvider = context.watch<BondProvider>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
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
                    'Bono del ${widget.bondResponseDto.issuerName ?? "-"}',
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
                  const SizedBox(height: 4),
                  Text(
                    'Fecha de emisión: ${widget.bondResponseDto.issueDate != null ? normalizeDate(widget.bondResponseDto.issueDate!) : "-"}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // Details Info
            Expanded(
              child: Container(
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Nombre:', 'Bono del ${widget.bondResponseDto.issuerName ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Valor nominal:', '${widget.bondResponseDto.nominalValue ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Valor comercial:', '${widget.bondResponseDto.commercialValue ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Tasa cupón:', '${widget.bondResponseDto.couponRate ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Tasa de mercado:', '${widget.bondResponseDto.marketRate ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Fecha de emisión:', widget.bondResponseDto.issueDate != null ? normalizeDate(widget.bondResponseDto.issueDate!) : "-"),
                      const SizedBox(height: 12),
                      _buildDetailRow('N° de operación:', widget.bondResponseDto.id?.toString() ?? "-"),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('TCEA:', bondProvider.paymentPlans.tcea?.toStringAsFixed(4) ?? "-", 'Tasa de Costo Efectivo Anual (emisor): mide el costo total anual del bono para el emisor.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('TREA:',bondProvider.paymentPlans.trea?.toStringAsFixed(4) ?? "-", 'Tasa de Rendimiento Efectivo Anual (bonista): mide el rendimiento anual real para el inversionista.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('Duración:', bondProvider.paymentPlans.duration?.toStringAsFixed(4) ?? "-", 'Duración: mide el plazo promedio ponderado de los flujos de caja del bono.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('Duración Modificada:', widget.bondResponseDto.modifiedDuration?.toStringAsFixed(4) ?? "-", 'Duración modificada: mide la sensibilidad del precio del bono ante cambios en la tasa de interés.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('Convexidad:', bondProvider.paymentPlans.convexity?.toStringAsFixed(4) ?? "-", 'Convexidad: mide la curvatura de la relación precio-tasa de interés del bono.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('Precio Máximo:', bondProvider.paymentPlans.maxMarketPrice?.toStringAsFixed(2) ?? "-", 'Precio máximo: precio máximo que el inversionista debería pagar para que el bono sea rentable.'),
                      const SizedBox(height: 20),

                      // Cash Flow Table
                      if (bondProvider.paymentPlans != null && bondProvider.paymentPlans.cashFlows!.isNotEmpty)
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
                              ...bondProvider.paymentPlans.cashFlows!.asMap().entries.map((entry) {
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
              ),
            ),
          ],
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
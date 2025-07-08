import 'package:flutter/material.dart';
import 'package:phoneplus/core/helpers/date_time_helper.dart';
import 'package:phoneplus/credits/domain/bond_response.dto.dart';
import 'package:phoneplus/credits/interfaces/screens/new_plan_screen.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';

import 'edit_bond_screen.dart';

class DetailsScreen extends StatelessWidget {
  final BondResponseDto bondResponseDto;
  const DetailsScreen({super.key, required this.bondResponseDto});

  @override
  Widget build(BuildContext context) {
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

            // Bond Details Card
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
                    'Bono del ${bondResponseDto.issuerName ?? "-"}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    bondResponseDto.username ?? "-",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Valor nominal: ${bondResponseDto.nominalValue ?? "-"}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Fecha de emisión: ${bondResponseDto.issueDate != null ? normalizeDate(bondResponseDto.issueDate!) : "-"}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // Botón Editar solo para emisores
            FutureBuilder<String?>(
              future: StorageHelper.getRole(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.data == "Seller") {
                  return Padding(
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
                              builder: (_) => EditBondScreen(bond: bondResponseDto),
                            ),
                          );
                        },
                        child: const Text('Editar Bono', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

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
                      _buildDetailRow('Nombre:', 'Bono del ${bondResponseDto.issuerName ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Valor nominal:', '${bondResponseDto.nominalValue ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Valor comercial:', '${bondResponseDto.commercialValue ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Tasa cupón:', '${bondResponseDto.couponRate ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Tasa de mercado:', '${bondResponseDto.marketRate ?? "-"}'),
                      const SizedBox(height: 12),
                      _buildDetailRow('Fecha de emisión:', bondResponseDto.issueDate != null ? normalizeDate(bondResponseDto.issueDate!) : "-"),
                      const SizedBox(height: 12),
                      _buildDetailRow('N° de operación:', bondResponseDto.id?.toString() ?? "-"),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('TCEA:', bondResponseDto.tcea?.toStringAsFixed(4) ?? "-", 'Tasa de Costo Efectivo Anual (emisor): mide el costo total anual del bono para el emisor.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('TREA:', bondResponseDto.trea?.toStringAsFixed(4) ?? "-", 'Tasa de Rendimiento Efectivo Anual (bonista): mide el rendimiento anual real para el inversionista.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('Duración:', bondResponseDto.duration?.toStringAsFixed(4) ?? "-", 'Duración: mide el plazo promedio ponderado de los flujos de caja del bono.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('Duración Modificada:', bondResponseDto.modifiedDuration?.toStringAsFixed(4) ?? "-", 'Duración modificada: mide la sensibilidad del precio del bono ante cambios en la tasa de interés.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('Convexidad:', bondResponseDto.convexity?.toStringAsFixed(4) ?? "-", 'Convexidad: mide la curvatura de la relación precio-tasa de interés del bono.'),
                      const SizedBox(height: 12),
                      _buildDetailRowWithInfo('Precio Máximo:', bondResponseDto.maxPrice?.toStringAsFixed(2) ?? "-", 'Precio máximo: precio máximo que el inversionista debería pagar para que el bono sea rentable.'),
                      const SizedBox(height: 20),

                      // Cash Flow Table
                      if (bondResponseDto.cashFlow != null && bondResponseDto.cashFlow!.isNotEmpty)
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
                              ...bondResponseDto.cashFlow!.asMap().entries.map((entry) {
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
                      title: Text(label),
                      content: Text(info),
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
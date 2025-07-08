import 'package:flutter/material.dart';
import 'package:phoneplus/core/helpers/date_time_helper.dart';
import 'package:phoneplus/credits/interfaces/providers/bond_provider.dart';
import 'package:phoneplus/credits/domain/bond_response.dto.dart';
import 'package:phoneplus/credits/interfaces/screens/details_screen.dart';
import 'package:provider/provider.dart';

class BondsScreen extends StatefulWidget {
  const BondsScreen({super.key});

  @override
  State<BondsScreen> createState() => _BondsScreenState();
}

class _BondsScreenState extends State<BondsScreen> {
  int? selectedBondIndex;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<BondProvider>(context, listen: false).getAvailableBonds());
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
                    'Bonos Disponibles',
                    style: TextStyle(
                      fontSize: 20,
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

            // Bonds List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: bondProvider.bondNumber,
                itemBuilder: (context, index) {
                  final bond = bondProvider.bonds[index];
                  final isSelected = selectedBondIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedBondIndex = isSelected ? null : index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A7C59),
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? Border.all(color: Colors.white, width: 3)
                            : null,
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
                            'Bono del ${bond.issuerName ?? "-"}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${bond.username ?? "-"}:',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Valor nominal: ${bond.nominalValue ?? "-"}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Fecha de emisión: ${bond.issueDate != null ? normalizeDate(bond.issueDate!) : "-"}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Request Button
            GestureDetector(
              onTap: selectedBondIndex != null
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsScreen(bondResponseDto: bondProvider.bonds[selectedBondIndex!]),
                  ),
                );
              }
                  : null,
              child: Container(
                margin: const EdgeInsets.all(16),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedBondIndex != null
                      ? const Color(0xFF4A7C59)
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Center(
                  child: Text(
                    'Mostrar Detalles',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
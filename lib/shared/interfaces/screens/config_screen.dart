import 'package:flutter/material.dart';
import 'package:phoneplus/credits/domain/payment_plan.dto.dart';
import 'package:phoneplus/shared/infraestructure/helpers/storage_helper.dart';
import 'package:phoneplus/shared/interfaces/screens/home_screen.dart';
import 'package:phoneplus/ui/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  final List<String> currencies = ['PEN', 'USD', 'EUR']; //TODO: Add more currencies as needed
  final List<String> rateTypes = ['Efectiva', 'Nominal', "Descuento"];
  final List<String> capitalizations = [ 'Cuatrimestral',
    'Semestral',
    'Anual',
    'Bimestral',
    'Mensual',
    'Semanal',
    'Diario'];


  String? selectedCurrency;
  String? selectedRateType;
  String? selectedCapitalization;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCurrency = prefs.getString('config_currency') ?? currencies[0];
      selectedRateType = prefs.getString('config_rateType') ?? rateTypes[0];
      selectedCapitalization = prefs.getString('config_capitalization') ?? capitalizations[0];
    });
  }

  Future<void> _saveConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('config_currency', selectedCurrency ?? currencies[0]);
    await prefs.setString('config_rateType', selectedRateType ?? rateTypes[0]);
    await prefs.setString('config_capitalization', selectedCapitalization ?? capitalizations[0]);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Configuración guardada correctamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración de Bonos'),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.black), // Fuerza texto negro por defecto
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Moneda', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              DropdownButton<String>(
                value: selectedCurrency,
                dropdownColor: Colors.white,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                iconEnabledColor: Colors.black,
                items: currencies.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Colors.black)),
                )).toList(),
                onChanged: (value) => setState(() => selectedCurrency = value),
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
              if (selectedRateType == 'Nominal') ...[
                const Text('Capitalización', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                DropdownButton<String>(
                  value: selectedCapitalization,
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  iconEnabledColor: Colors.black,
                  items: capitalizations.map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: const TextStyle(color: Colors.black)),
                  )).toList(),
                  onChanged: (value) => setState(() => selectedCapitalization = value),
                ),
              ],
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: background,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: _saveConfig,
                  child: const Text('Guardar configuración', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: background,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () async{
                    await StorageHelper.removeCredentials();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                  },
                  child: const Text('Cerrar sesión', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

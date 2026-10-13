import 'package:flutter/material.dart';

void main() {
  runApp(const EcoSmartApp());
}

class EcoSmartApp extends StatelessWidget {
  const EcoSmartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SDG 7: Eco-Smart Energy Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(
          0xFFE8F5E9,
        ), // Warna latar belakang hijau muda
      ),
      home: const TurbineControlPage(),
    );
  }
}

class TurbineControlPage extends StatefulWidget {
  const TurbineControlPage({Key? key}) : super(key: key);

  @override
  State<TurbineControlPage> createState() => _TurbineControlPageState();
}

class _TurbineControlPageState extends State<TurbineControlPage> {
  // Status Interaktif
  Offset _cardOffset = Offset.zero;
  bool _isOn = true;
  bool _isSupercharged = false;

  // Counter Statistik
  int _dragCount = 0;
  int _tapCount = 0;
  int _longPressCount = 0;

  void _resetPositionAndStatus() {
    setState(() {
      _cardOffset = Offset.zero;
      _isOn = true;
      _isSupercharged = false;
      _dragCount = 0;
      _tapCount = 0;
      _longPressCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Nilai dinamis berdasarkan status
    final String powerOutput = _isSupercharged
        ? '1,450 W'
        : (_isOn ? '950 W' : '0 W');
    final String efficiency = _isSupercharged
        ? '99.4%'
        : (_isOn ? '98.5%' : '0.0%');
    final String co2Saved = _isSupercharged
        ? '1.20 kg/j'
        : (_isOn ? '0.81 kg/j' : '0.00 kg/j');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Atas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF2E7D32), // Hijau tua khas panel
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'SDG 7: Eco-Smart Energy Hub',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kontrol Panel Turbin Mikro-Hidro',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Geser, Ketuk & Tahan Kartu!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Area Kerja Tengah (Tempat Kartu Digeser)
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Kartu yang dapat digeser (Draggable / Positioned)
                  Positioned(
                    left:
                        MediaQuery.of(context).size.width / 2 -
                        160 +
                        _cardOffset.dx,
                    top: 40 + _cardOffset.dy,
                    child: GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          _cardOffset += details.delta;
                          _dragCount++;
                        });
                      },
                      onTap: () {
                        setState(() {
                          _isOn = !_isOn;
                          _tapCount++;
                        });
                      },
                      onLongPress: () {
                        setState(() {
                          _isSupercharged = !_isSupercharged;
                          _longPressCount++;
                        });
                      },
                      child: Container(
                        width: 320,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _isSupercharged
                              ? const Color(0xFF004D40)
                              : const Color(0xFF00695C),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Bar Atas Kartu
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.bolt,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'TURBIN UNIT #01',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _isSupercharged
                                        ? Colors.amber[700]
                                        : Colors.teal[800],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    _isSupercharged
                                        ? 'SUPERCHARGED'
                                        : (_isOn ? 'ACTIVE' : 'OFF'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Tombol Ikon Pusat (Indikator Status Ketuk)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Icon(
                                Icons.settings,
                                color: _isOn ? Colors.white : Colors.white54,
                                size: 36,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Informasi Metrik (Daya, Efisiensi, CO2)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildMetricItem(
                                  Icons.power,
                                  powerOutput,
                                  'Output Daya',
                                ),
                                _buildMetricItem(
                                  Icons.trending_up,
                                  efficiency,
                                  'Efisiensi',
                                ),
                                _buildMetricItem(
                                  Icons.eco,
                                  co2Saved,
                                  'CO₂ Dihindari',
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Teks Bantuan di Bawah Kartu (Tidak Terpotong)
                            Text(
                              _isSupercharged
                                  ? 'Tahan lagi untuk kembali normal'
                                  : 'Ketuk untuk On/Off • Tahan untuk Supercharge',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
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

            // Panel Statistik Kontrol di Bagian Bawah
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildControlCounter(
                        'Drag/Pan',
                        'Seret kartu',
                        '$_dragCount',
                      ),
                      _buildControlCounter('Tap', 'On / Off', '$_tapCount'),
                      _buildControlCounter(
                        'Long Press',
                        'Supercharge',
                        '$_longPressCount',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _resetPositionAndStatus,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF37474F),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text(
                        'Reset Posisi & Status',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget Pembantu untuk Metrik di dalam Kartu
  Widget _buildMetricItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }

  // Widget Pembantu untuk Kotak Counter Panel Bawah
  Widget _buildControlCounter(String title, String subtitle, String count) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.touch_app, size: 14, color: Color(0xFF2E7D32)),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 9, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

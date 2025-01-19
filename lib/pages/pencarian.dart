import 'package:flutter/material.dart';

class PencarianPage extends StatefulWidget {
  @override
  _PencarianPageState createState() => _PencarianPageState();
}

class _PencarianPageState extends State<PencarianPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Semua';
  final List<String> _filters = ['Semua', 'IT', 'Design', 'Marketing', 'Finance'];

  final List<Map<String, dynamic>> _lowonganKerja = [
    {
      'posisi': 'Flutter Developer',
      'perusahaan': 'PT Teknologi Maju',
      'lokasi': 'Jakarta',
      'gaji': 'Rp 8-12 juta',
      'kategori': 'IT'
    },
    {
      'posisi': 'UI/UX Designer', 
      'perusahaan': 'Creative Digital Studio',
      'lokasi': 'Bandung',
      'gaji': 'Rp 7-10 juta',
      'kategori': 'Design'
    },
    {
      'posisi': 'Digital Marketing',
      'perusahaan': 'Startup Indonesia', 
      'lokasi': 'Surabaya',
      'gaji': 'Rp 6-9 juta',
      'kategori': 'Marketing'
    },
  ];

  List<Map<String, dynamic>> get filteredLowongan {
    if (_selectedFilter == 'Semua') {
      return _lowonganKerja;
    }
    return _lowonganKerja
        .where((lowongan) => lowongan['kategori'] == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[100]!, Colors.white, Colors.purple[50]!],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temukan',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [Colors.blue[800]!, Colors.purple[800]!],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                  Text(
                    'Pekerjaan Impianmu',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: [Colors.blue[800]!, Colors.purple[800]!],
                        ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.blue[50]!],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[100]!,
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari lowongan pekerjaan...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Material(
                            elevation: 2,
                            shadowColor: Colors.blue[100],
                            borderRadius: BorderRadius.circular(25),
                            child: ChoiceChip(
                              label: Text(
                                _filters[index],
                                style: TextStyle(
                                  color: _selectedFilter == _filters[index]
                                      ? Colors.white
                                      : Colors.blue[600],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              selected: _selectedFilter == _filters[index],
                              selectedColor: Colors.blue[400],
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              onSelected: (selected) {
                                setState(() {
                                  _selectedFilter = _filters[index];
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: filteredLowongan.length,
                itemBuilder: (context, index) {
                  final lowongan = filteredLowongan[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.blue[50]!],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[100]!,
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          // Implementasi detail lowongan
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      lowongan['posisi'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[900],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      lowongan['kategori'],
                                      style: TextStyle(
                                        color: Colors.blue[800],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                lowongan['perusahaan'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, 
                                       color: Colors.blue[600], size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    lowongan['lokasi'],
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Icon(Icons.attach_money_outlined, 
                                       color: Colors.blue[600], size: 20),
                                  SizedBox(width: 5),
                                  Text(
                                    lowongan['gaji'],
                                    style: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

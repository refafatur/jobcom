import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final List<Map<String, dynamic>> _lowonganTerbaru = [
    {
      'posisi': 'Flutter Developer',
      'perusahaan': 'PT Teknologi Maju',
      'lokasi': 'Jakarta',
      'gaji': 'Rp 8-12 juta',
      'logo': 'https://picsum.photos/50',
      'warna': Colors.blue[400],
    },
    {
      'posisi': 'UI/UX Designer', 
      'perusahaan': 'Creative Digital Studio',
      'lokasi': 'Bandung',
      'gaji': 'Rp 7-10 juta',
      'logo': 'https://picsum.photos/51',
      'warna': Colors.purple[400],
    },
    {
      'posisi': 'Frontend Developer',
      'perusahaan': 'Startup Indonesia',
      'lokasi': 'Surabaya',
      'gaji': 'Rp 6-9 juta', 
      'logo': 'https://picsum.photos/52',
      'warna': Colors.orange[400],
    },
  ];

  String userType = 'pencari';
  String userName = '';
  String userEmail = '';
  String userId = '';

  final _formKey = GlobalKey<FormState>();
  final _posisiController = TextEditingController();
  final _perusahaanController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _gajiController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _persyaratanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userType = prefs.getString('userType') ?? 'pencari';
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      userId = prefs.getString('userId') ?? '';
    });
  }

  void _showFormLowongan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buat Lowongan Baru',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _posisiController,
                    decoration: InputDecoration(
                      labelText: 'Posisi',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Posisi tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _perusahaanController,
                    decoration: InputDecoration(
                      labelText: 'Nama Perusahaan',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama perusahaan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _lokasiController,
                    decoration: InputDecoration(
                      labelText: 'Lokasi',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lokasi tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _gajiController,
                    decoration: InputDecoration(
                      labelText: 'Kisaran Gaji',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kisaran gaji tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _deskripsiController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Deskripsi Pekerjaan',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _persyaratanController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Persyaratan',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Persyaratan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Implementasi logika penyimpanan lowongan
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Posting Lowongan',
                      style: TextStyle(fontSize: 16),
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
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header dengan Animasi
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(milliseconds: 800),
                        builder: (context, double value, child) {
                          return Opacity(
                            opacity: value,
                            child: Padding(
                              padding: EdgeInsets.only(top: value * 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Selamat Datang, ${userName}!',
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
                                    userType == 'pencari' 
                                      ? 'Temukan pekerjaan impian Anda'
                                      : 'Posting lowongan pekerjaan Anda',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24),

                      if (userType == 'pencari') ...[
                        // Search Bar yang Lebih Menarik
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 15,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari lowongan impianmu...',
                              prefixIcon: Icon(Icons.search, color: Colors.blue[400]),
                              suffixIcon: Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.blue[400]!, Colors.blue[600]!],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(Icons.tune, color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        // Kategori Pekerjaan dengan Animasi
                        Text(
                          'Kategori Pekerjaan',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = LinearGradient(
                                colors: [Colors.blue[800]!, Colors.purple[800]!],
                              ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                          ),
                        ),
                        SizedBox(height: 16),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildKategoriCard('IT & Software', Icons.computer, Colors.blue[400]!),
                              _buildKategoriCard('Desain', Icons.brush, Colors.purple[400]!),
                              _buildKategoriCard('Marketing', Icons.trending_up, Colors.orange[400]!),
                              _buildKategoriCard('Keuangan', Icons.attach_money, Colors.green[400]!),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                      ],

                      // Lowongan Terbaru dengan Animasi
                      Text(
                        userType == 'pencari' ? 'Lowongan Terbaru' : 'Lowongan Anda',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: [Colors.blue[800]!, Colors.purple[800]!],
                            ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                        ),
                      ),
                      SizedBox(height: 16),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _lowonganTerbaru.length,
                        itemBuilder: (context, index) {
                          return _buildLowonganCard(_lowonganTerbaru[index], index);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (userType == 'penyedia')
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton.extended(
                    onPressed: _showFormLowongan,
                    icon: Icon(Icons.add),
                    label: Text('Buat Lowongan'),
                    backgroundColor: Colors.blue[600],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKategoriCard(String title, IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Material(
        elevation: 8,
        shadowColor: color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 120,
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color, color.withOpacity(0.7)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 30, color: Colors.white),
                ),
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLowonganCard(Map<String, dynamic> lowongan, int index) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Material(
                elevation: 8,
                shadowColor: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.blue[50]!],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lowongan['posisi'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    lowongan['perusahaan'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue[50],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                userType == 'pencari' ? Icons.bookmark_border : Icons.edit,
                                color: Colors.blue[400],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip(Icons.location_on, lowongan['lokasi']),
                            SizedBox(width: 12),
                            _buildInfoChip(Icons.attach_money, lowongan['gaji']),
                          ],
                        ),
                        SizedBox(height: 16),
                        if (userType == 'pencari')
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            child: Text(
                              'Lamar Sekarang',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.blue[600]),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.blue[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
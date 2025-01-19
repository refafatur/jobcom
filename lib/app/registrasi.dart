import 'package:flutter/material.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrasiPage extends StatefulWidget {
  @override
  _RegistrasiPageState createState() => _RegistrasiPageState();
}

class _RegistrasiPageState extends State<RegistrasiPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPencariKerja = true;

  // Controller untuk Pencari Kerja
  final _namaPencariController = TextEditingController();
  final _emailPencariController = TextEditingController();
  final _passwordPencariController = TextEditingController();
  String _spesialisasiTerpilih = 'Programmer';
  final _lokasiPencariController = TextEditingController();

  // Controller untuk Penyedia Kerja
  final _namaPerusahaanController = TextEditingController();
  final _emailPerusahaanController = TextEditingController();
  final _passwordPerusahaanController = TextEditingController();
  final _bidangPerusahaanController = TextEditingController();
  final _lokasiPerusahaanController = TextEditingController();

  final List<String> _spesialisasiList = [
    'Programmer',
    'Desainer Grafis',
    'Admin IT',
    'System Analyst',
    'UI/UX Designer',
    'Network Engineer'
  ];

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/api/users'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'tipe': _isPencariKerja ? 'pencari' : 'penyedia',
            'nama': _isPencariKerja 
              ? _namaPencariController.text 
              : _namaPerusahaanController.text,
            'email': _isPencariKerja
              ? _emailPencariController.text
              : _emailPerusahaanController.text,
            'password': _isPencariKerja
              ? _passwordPencariController.text 
              : _passwordPerusahaanController.text,
            'spesialisasi': _isPencariKerja ? _spesialisasiTerpilih : null,
            'bidang': _isPencariKerja ? null : _bidangPerusahaanController.text,
            'lokasi': _isPencariKerja
              ? _lokasiPencariController.text
              : _lokasiPerusahaanController.text,
          }),
        );

        print('Status Code: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registrasi berhasil!')),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          throw Exception('Gagal melakukan registrasi: ${response.statusCode}');
        }
      } catch (e) {
        print('Error during registration: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal melakukan registrasi. Silakan coba lagi.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.send,
                  size: 100,
                  color: Colors.blue,
                ),
                SizedBox(height: 20),
                Text(
                  'Daftar di JobCom',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => setState(() => _isPencariKerja = true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isPencariKerja ? Colors.blue : Colors.grey,
                        ),
                        child: Text('Pencari Kerja'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => setState(() => _isPencariKerja = false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: !_isPencariKerja ? Colors.blue : Colors.grey,
                        ),
                        child: Text('Penyedia Kerja'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                if (_isPencariKerja) ...[
                  // Form Pencari Kerja
                  TextFormField(
                    controller: _namaPencariController,
                    decoration: InputDecoration(
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _emailPencariController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Email tidak boleh kosong';
                      if (!value.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordPencariController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Password tidak boleh kosong';
                      if (value.length < 6) return 'Password minimal 6 karakter';
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  DropdownButtonFormField(
                    value: _spesialisasiTerpilih,
                    decoration: InputDecoration(
                      labelText: 'Spesialisasi',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.work),
                    ),
                    items: _spesialisasiList.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _spesialisasiTerpilih = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _lokasiPencariController,
                    decoration: InputDecoration(
                      labelText: 'Lokasi',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Lokasi tidak boleh kosong' : null,
                  ),
                ] else ...[
                  // Form Penyedia Kerja
                  TextFormField(
                    controller: _namaPerusahaanController,
                    decoration: InputDecoration(
                      labelText: 'Nama Perusahaan',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.business),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Nama perusahaan tidak boleh kosong' : null,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _emailPerusahaanController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Perusahaan',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Email tidak boleh kosong';
                      if (!value.contains('@')) return 'Email tidak valid';
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordPerusahaanController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Password tidak boleh kosong';
                      if (value.length < 6) return 'Password minimal 6 karakter';
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _bidangPerusahaanController,
                    decoration: InputDecoration(
                      labelText: 'Bidang Perusahaan',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.category),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Bidang perusahaan tidak boleh kosong' : null,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _lokasiPerusahaanController,
                    decoration: InputDecoration(
                      labelText: 'Lokasi',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Lokasi tidak boleh kosong' : null,
                  ),
                ],
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _register,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Daftar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Sudah punya akun? Masuk di sini',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose semua controller
    _namaPencariController.dispose();
    _emailPencariController.dispose();
    _passwordPencariController.dispose();
    _lokasiPencariController.dispose();
    _namaPerusahaanController.dispose();
    _emailPerusahaanController.dispose();
    _passwordPerusahaanController.dispose();
    _bidangPerusahaanController.dispose();
    _lokasiPerusahaanController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/db_helper.dart';
import '../models/peminjaman.dart';

class FormScreen extends StatefulWidget {
  final Peminjaman? data;
  const FormScreen({this.data, super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  final judul = TextEditingController();
  final nomor = TextEditingController();
  final penerbit = TextEditingController();
  final tahun = TextEditingController();

  final nama = TextEditingController();
  final npm = TextEditingController();
  final prodi = TextEditingController();
  final alamat = TextEditingController();
  final telp = TextEditingController();

  String status = 'Dipinjam';

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      judul.text = widget.data!.judulBuku;
      nomor.text = widget.data!.nomorBuku;
      penerbit.text = widget.data!.penerbit;
      tahun.text = widget.data!.tahunTerbit;
      nama.text = widget.data!.nama;
      npm.text = widget.data!.npm;
      prodi.text = widget.data!.prodi;
      alamat.text = widget.data!.alamat;
      telp.text = widget.data!.noTelp;
      status = widget.data!.status;
    }
  }

  InputDecoration inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final tanggalPinjam = DateFormat('yyyy-MM-dd').format(now);
    final tanggalKembali =
        DateFormat('yyyy-MM-dd').format(now.add(const Duration(days: 7)));

    return Scaffold(
      appBar: AppBar(title: const Text('Form Peminjaman Buku')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ===== DATA BUKU =====
              const Text(
                'Data Buku',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: judul,
                decoration: inputStyle('Judul Buku', Icons.book),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: nomor,
                decoration: inputStyle('Nomor Buku', Icons.confirmation_number),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: penerbit,
                decoration: inputStyle('Penerbit', Icons.business),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: tahun,
                keyboardType: TextInputType.number,
                decoration: inputStyle('Tahun Terbit', Icons.date_range),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),

              const SizedBox(height: 25),

              /// ===== DATA PEMINJAM =====
              const Text(
                'Data Peminjam',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: nama,
                decoration: inputStyle('Nama Peminjam', Icons.person),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: npm,
                decoration: inputStyle('NPM', Icons.badge),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: prodi,
                decoration: inputStyle('Program Studi', Icons.school),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: alamat,
                decoration: inputStyle('Alamat', Icons.home),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: telp,
                keyboardType: TextInputType.phone,
                decoration: inputStyle('Nomor Telepon', Icons.phone),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField(
                value: status,
                decoration: inputStyle('Status Peminjaman', Icons.info),
                items: ['Dipinjam', 'Kembali']
                    .map((e) =>
                        DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => status = v.toString()),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Simpan'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final data = Peminjaman(
                        id: widget.data?.id,
                        judulBuku: judul.text,
                        nomorBuku: nomor.text,
                        penerbit: penerbit.text,
                        tahunTerbit: tahun.text,
                        nama: nama.text,
                        npm: npm.text,
                        prodi: prodi.text,
                        alamat: alamat.text,
                        noTelp: telp.text,
                        tanggalPinjam: tanggalPinjam,
                        tanggalKembali: tanggalKembali,
                        status: status,
                      );

                      widget.data == null
                          ? await DBHelper.insert(data)
                          : await DBHelper.update(data);

                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

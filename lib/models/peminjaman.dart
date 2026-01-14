class Peminjaman {
  int? id;
  String judulBuku;
  String nomorBuku;
  String penerbit;
  String tahunTerbit;
  String nama;
  String npm;
  String prodi;
  String alamat;
  String noTelp;
  String tanggalPinjam;
  String tanggalKembali;
  String status;

  Peminjaman({
    this.id,
    required this.judulBuku,
    required this.nomorBuku,
    required this.penerbit,
    required this.tahunTerbit,
    required this.nama,
    required this.npm,
    required this.prodi,
    required this.alamat,
    required this.noTelp,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul_buku': judulBuku,
      'nomor_buku': nomorBuku,
      'penerbit': penerbit,
      'tahun_terbit': tahunTerbit,
      'nama': nama,
      'npm': npm,
      'prodi': prodi,
      'alamat': alamat,
      'no_telp': noTelp,
      'tanggal_pinjam': tanggalPinjam,
      'tanggal_kembali': tanggalKembali,
      'status': status,
    };
  }

  factory Peminjaman.fromMap(Map<String, dynamic> map) {
    return Peminjaman(
      id: map['id'],
      judulBuku: map['judul_buku'],
      nomorBuku: map['nomor_buku'],
      penerbit: map['penerbit'],
      tahunTerbit: map['tahun_terbit'],
      nama: map['nama'],
      npm: map['npm'],
      prodi: map['prodi'],
      alamat: map['alamat'],
      noTelp: map['no_telp'],
      tanggalPinjam: map['tanggal_pinjam'],
      tanggalKembali: map['tanggal_kembali'],
      status: map['status'],
    );
  }
}

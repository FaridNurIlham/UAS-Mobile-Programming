import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/peminjaman.dart';

class DBHelper {
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'perpustakaan.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE peminjaman (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul_buku TEXT,
            nomor_buku TEXT,
            penerbit TEXT,
            tahun_terbit TEXT,
            nama TEXT,
            npm TEXT,
            prodi TEXT,
            alamat TEXT,
            no_telp TEXT,
            tanggal_pinjam TEXT,
            tanggal_kembali TEXT,
            status TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insert(Peminjaman data) async {
    final db = await database();
    await db.insert('peminjaman', data.toMap());
  }

  static Future<List<Peminjaman>> getAll() async {
    final db = await database();
    final List<Map<String, dynamic>> maps =
        await db.query('peminjaman');
    return List.generate(maps.length, (i) {
      return Peminjaman.fromMap(maps[i]);
    });
  }

  static Future<void> update(Peminjaman data) async {
    final db = await database();
    await db.update(
      'peminjaman',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }

  static Future<void> delete(int id) async {
    final db = await database();
    await db.delete(
      'peminjaman',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

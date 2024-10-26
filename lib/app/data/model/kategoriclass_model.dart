class KategoriClass {
  final int? id;
  final String nama;

  KategoriClass({
    this.id,
    required this.nama,
  });

  factory KategoriClass.fromJson(Map<String, dynamic> json) {
    return KategoriClass(
      id: json['id'] as int?,
      nama: json['nama'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
    };
  }
}

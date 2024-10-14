// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class BacaArtikel {
  String? status;
  String? message;
  Data? data;

  BacaArtikel({this.status, this.message, this.data});

  BacaArtikel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? judul;
  String? ringkasan;
  String? foto;
  String? konten;
  int? likeCount;
  int? viewCount;
  bool? isPublished;
  String? createdAt;
  String? updatedAt;
  int? likesCount;
  bool? isLiked;
  bool? isBookmarked;
  String? penulis;

  Data(
      {this.id,
      this.userId,
      this.judul,
      this.ringkasan,
      this.foto,
      this.konten,
      this.likeCount,
      this.viewCount,
      this.isPublished,
      this.createdAt,
      this.updatedAt,
      this.likesCount,
      this.isLiked,
      this.isBookmarked,
      this.penulis});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    judul = json['judul'];
    ringkasan = json['ringkasan'];
    foto = json['foto'];
    konten = json['konten'];
    likeCount = json['like_count'];
    viewCount = json['view_count'];
    isPublished = json['is_published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
    isLiked = json['is_liked'];
    isBookmarked = json['is_bookmarked'];
    penulis = json['penulis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['judul'] = this.judul;
    data['ringkasan'] = this.ringkasan;
    data['foto'] = this.foto;
    data['konten'] = this.konten;
    data['like_count'] = this.likeCount;
    data['view_count'] = this.viewCount;
    data['is_published'] = this.isPublished;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['likes_count'] = this.likesCount;
    data['is_liked'] = this.isLiked;
    data['is_bookmarked'] = this.isBookmarked;
    data['penulis'] = this.penulis;
    return data;
  }
}

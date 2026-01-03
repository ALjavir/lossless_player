import 'dart:ffi';

class SongModels {
  final String? coverImage;
  final String name;
  final String? artist;
  final String? genres;
  final String? albam;
  final Int? year;
  final double endtime;

  SongModels(
      {required this.endtime,
      required this.name,
      this.artist,
      this.genres,
      this.albam,
      this.year,
      this.coverImage});
}

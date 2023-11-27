class DisneyCharacters {
  final Info? info;
  final List<Data>? data;

  DisneyCharacters({
    this.info,
    this.data,
  });

  DisneyCharacters.fromJson(Map<String, dynamic> json)
      : info = (json['info'] as Map<String, dynamic>?) != null
            ? Info.fromJson(json['info'] as Map<String, dynamic>)
            : null,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'info': info?.toJson(), 'data': data?.map((e) => e.toJson()).toList()};
}

class Info {
  final int? count;
  final int? totalPages;
  final dynamic previousPage;
  final String? nextPage;

  Info({
    this.count,
    this.totalPages,
    this.previousPage,
    this.nextPage,
  });

  Info.fromJson(Map<String, dynamic> json)
      : count = json['count'] as int?,
        totalPages = json['totalPages'] as int?,
        previousPage = json['previousPage'],
        nextPage = json['nextPage'] as String?;

  Map<String, dynamic> toJson() => {
        'count': count,
        'totalPages': totalPages,
        'previousPage': previousPage,
        'nextPage': nextPage
      };
}

class Data {
  final int? id;
  final List<String>? films;
  final List<dynamic>? shortFilms;
  final List<String>? tvShows;
  final List<String>? videoGames;
  final List<dynamic>? parkAttractions;
  final List<dynamic>? allies;
  final List<dynamic>? enemies;
  final String? sourceUrl;
  final String? name;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;
  final String? url;
  final int? v;

  Data({
    this.id,
    this.films,
    this.shortFilms,
    this.tvShows,
    this.videoGames,
    this.parkAttractions,
    this.allies,
    this.enemies,
    this.sourceUrl,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.v,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as int?,
        films =
            (json['films'] as List?)?.map((dynamic e) => e as String).toList(),
        shortFilms = json['shortFilms'] as List?,
        tvShows = (json['tvShows'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        videoGames = (json['videoGames'] as List?)
            ?.map((dynamic e) => e as String)
            .toList(),
        parkAttractions = json['parkAttractions'] as List?,
        allies = json['allies'] as List?,
        enemies = json['enemies'] as List?,
        sourceUrl = json['sourceUrl'] as String?,
        name = json['name'] as String?,
        imageUrl = json['imageUrl'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        url = json['url'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
        '_id': id,
        'films': films,
        'shortFilms': shortFilms,
        'tvShows': tvShows,
        'videoGames': videoGames,
        'parkAttractions': parkAttractions,
        'allies': allies,
        'enemies': enemies,
        'sourceUrl': sourceUrl,
        'name': name,
        'imageUrl': imageUrl,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'url': url,
        '__v': v
      };
}

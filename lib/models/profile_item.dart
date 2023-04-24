class Market {
  final int? id;
  final String marketName;

  Market({
    this.id,
    required this.marketName,
  });
}

class ProfileItem {
  final int? id;
  final String name;
  final List<Market> markets;

  ProfileItem({
    this.id,
    required this.name,
    required this.markets,
  });
}

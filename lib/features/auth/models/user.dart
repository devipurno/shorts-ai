enum SubscriptionTier { free, standard, premium, lifetime }

class User {
  const User({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    required this.tier,
    required this.createdAt,
  });

  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final SubscriptionTier tier;
  final DateTime createdAt;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is User &&
            other.id == id &&
            other.email == email &&
            other.name == name &&
            other.avatarUrl == avatarUrl &&
            other.tier == tier &&
            other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(id, email, name, avatarUrl, tier, createdAt);
}

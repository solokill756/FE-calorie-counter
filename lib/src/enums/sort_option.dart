enum SortOption {
  mostRecent('most_recent', 'Most Recent', '🕐'),
  alphabeticalAZ('alphabetical_az', 'A-Z', '🔤'),
  alphabeticalZA('alphabetical_za', 'Z-A', '🔡');

  const SortOption(this.value, this.displayName, this.icon);

  final String value;
  final String displayName;
  final String icon;

  // Helper methods
  static SortOption fromString(String value) {
    return SortOption.values.firstWhere(
      (option) => option.value == value,
      orElse: () => SortOption.mostRecent,
    );
  }

  // Get description for each sort option
  String get description {
    switch (this) {
      case SortOption.mostRecent:
        return 'Sort by recently used foods';
      case SortOption.alphabeticalAZ:
        return 'Sort alphabetically A to Z';
      case SortOption.alphabeticalZA:
        return 'Sort alphabetically Z to A';
    }
  }

  // Get Firestore field name for sorting
  String get firestoreField {
    switch (this) {
      case SortOption.mostRecent:
        return 'last_used';
      case SortOption.alphabeticalAZ:
      case SortOption.alphabeticalZA:
        return 'name';
    }
  }

  // Get sort direction for Firestore
  bool get isDescending {
    switch (this) {
      case SortOption.mostRecent:
      case SortOption.alphabeticalZA:
        return true;
      case SortOption.alphabeticalAZ:
        return false;
    }
  }
}

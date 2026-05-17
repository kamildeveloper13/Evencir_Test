enum BottomNavItem {
  home(
    'Nutrition',
    'assets/icons/nutritions.png',
    'assets/icons/nutritions.png',
  ),
  workouts('Plan', 'assets/icons/plan.png', 'assets/icons/plan.png'),
  calendar('Mood', 'assets/icons/moods.png', 'assets/icons/moods.png'),
  profile('Profile', 'assets/icons/profile.png', 'assets/icons/profile.png');

  final String label;
  final String iconPath;
  final String activeIconPath;

  const BottomNavItem(this.label, this.iconPath, this.activeIconPath);
}

class ProfileData {
  final String username;
  final String email;
  final String phone;
  final String photoUrl;

  ProfileData({
    required this.username,
    required this.email,
    required this.phone,
    this.photoUrl = '',
  });
}

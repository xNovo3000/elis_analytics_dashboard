class Session {

  factory Session.fromJson(final Map<String, dynamic> map) => Session(
      token: map['token'],
      refreshToken: map['refreshToken']
  );

  Session({
    required this.token,
    required this.refreshToken,
  }) : expires = DateTime.now().add(const Duration(minutes: 10));

  final String token;
  final String refreshToken;
  final DateTime expires;

  bool get expired => expires.isBefore(DateTime.now());

  @override bool operator ==(Object other) => other is Session ? token == other.token : false;
  @override int get hashCode => token.hashCode;

}
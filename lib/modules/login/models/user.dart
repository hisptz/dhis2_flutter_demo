class User {
  String? id;
  bool? isLogin;
  String? name;
  String? serverUrl;
  String? username;
  String? password;
  String? email;
  String? phoneNumber;
  String? introduction;
  String? jobTitle;
  String? gender;
  String? birthday;
  String? nationality;
  String? employer;
  String? education;
  String? interests;
  String? languages;
  List<String>? userRoles;
  List<String>? userGroups;
  List<String>? userOrgUnitIds;
  List<String>? programs;
  List<String>? dataSets;
  List<String>? authorities;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.serverUrl,
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.introduction = '',
    this.jobTitle = '',
    this.gender = '',
    this.birthday = '',
    this.nationality = '',
    this.employer = '',
    this.education = '',
    this.interests = '',
    this.languages = '',
    this.isLogin = true,
    this.userRoles = const [],
    this.userGroups = const [],
    this.userOrgUnitIds = const [],
    this.programs = const [],
    this.dataSets = const [],
    this.authorities = const [],
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['serverUrl'] = serverUrl;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    data['isLogin'] = isLogin! ? 1 : 0;
    data['introduction'] = introduction;
    data['jobTitle'] = jobTitle;
    data['gender'] = gender;
    data['birthday'] = birthday;
    data['nationality'] = nationality;
    data['employer'] = employer;
    data['education'] = education;
    data['interests'] = interests;
    data['languages'] = languages;
    data['userRoles'] = userRoles!.join(";");
    data['userGroups'] = userGroups!.join(";");
    data['userOrgUnitIds'] = userOrgUnitIds!.join(";");
    data['programs'] = programs!.join(";");
    data['dataSets'] = dataSets!.join(";");
    data['authorities'] = authorities!.join(";");
    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
    serverUrl = mapData['serverUrl'];
    username = mapData['username'];
    password = mapData['password'];
    email = mapData['email'];
    phoneNumber = mapData['phoneNumber'];
    introduction = mapData['introduction'];
    jobTitle = mapData['jobTitle'];
    gender = mapData['gender'];
    birthday = mapData['birthday'];
    nationality = mapData['nationality'];
    employer = mapData['employer'];
    education = mapData['education'];
    interests = mapData['interests'];
    languages = mapData['languages'];
    isLogin = '${mapData['isLogin']}' == '1';
    userRoles = '${mapData['userRoles']}'.split(';');
    userGroups = '${mapData['userGroups']}'.split(';');
    userOrgUnitIds = '${mapData['userOrgUnitIds']}'.split(';');
    programs = '${mapData['programs']}'.split(';');
    dataSets = '${mapData['dataSets']}'.split(';');
    authorities = '${mapData['authorities']}'.split(';');
  }

  factory User.fromJson(
    dynamic json,
    String? username,
    String? password,
    String? serverUrl,
  ) {
    List organisationUnitList = json['organisationUnits'] as List<dynamic>;
    List authoritiesList = json['authorities'] as List<dynamic>;
    List programsList = json['programs'] as List<dynamic>;
    List dataSetsList = json['dataSets'] as List<dynamic>;
    return User(
      name: json['name'],
      id: json['id'],
      serverUrl: serverUrl,
      password: password,
      username: username,
      email: json["email"],
      phoneNumber: json["phoneNumber"] ?? '',
      introduction: json["introduction"] ?? '',
      jobTitle: json["jobTitle"] ?? '',
      gender: json["gender"] ?? '',
      birthday: json["birthday"] ?? '',
      nationality: json["nationality"] ?? '',
      employer: json["employer"] ?? '',
      education: json["education"] ?? '',
      interests: json["interests"] ?? '',
      languages: json["languages"] ?? '',
      userGroups: getUserGroups(json),
      userRoles: getUserRoles(json),
      isLogin: true,
      authorities: authoritiesList.map((authority) => '$authority').toList(),
      programs: programsList.map((program) => '$program').toList(),
      dataSets: dataSetsList.map((dataSet) => '$dataSet').toList(),
      userOrgUnitIds: organisationUnitList
          .map((organisationUnit) => '${organisationUnit["id"]}')
          .toList(),
    );
  }

  static List<String> getUserRoles(
    dynamic json,
  ) {
    Map userCredentials = json["userCredentials"];
    List userRolesList = userCredentials['userRoles'] as List<dynamic>;
    return userRolesList
        .map((dynamic userRole) => '${userRole["name"]}')
        .toList();
  }

  static List<String> getUserGroups(
    dynamic json,
  ) {
    List userGroupsList = json['userGroups'] as List<dynamic>;
    return userGroupsList
        .map((dynamic userGroup) => '${userGroup["name"]}}')
        .toList();
  }

  @override
  String toString() {
    return '<$id $username>';
  }
}

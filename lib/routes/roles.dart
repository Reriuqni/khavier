/// Type of rights
enum Roles {
  AUTH, // User is not signed in - show a sign-in screen
  ADMIN,
  MANAGER,
  NEW_USER,
  ROLE_NOT_FOUND,
}

// List<String> getListNames() {
//   return Roles.values
//       .where((e) => ![Roles.AUTH, Roles.ROLE_NOT_FOUND].contains(e))
//       .map((e) => e.name)
//       .toList();
// }

extension RolesExtension on Roles {
  /// Retrun List of Roles without 'AUTH' and 'ROLE_NOT_FOUND'
  static List<String> getHumanListNames() {
    return Roles.values
        .where((e) => ![Roles.AUTH, Roles.ROLE_NOT_FOUND].contains(e))
        .map((e) => e.name)
        .toList();
  }

  /// Find Role in Roles and return Name of Role. If Role not found then method return 'NEW_USER'
  static String getNameOfRole({required Roles role}) {
    return Roles.values
        .firstWhere(
          (e) => e.name == role.name,
          orElse: () => Roles.NEW_USER,
        )
        .name;
  }

  /// Find Role in Roles by findName and return Role. If Role not found then return Roles.ROLE_NOT_FOUND
  static Roles getRoleByName({required String findName}) {
    return Roles.values.firstWhere(
      (e) => e.name == findName,
      orElse: () => Roles.ROLE_NOT_FOUND,
    );
  }
}

enum AccountingInOrOutType {
  incoming,
  outgoing;

  static AccountingInOrOutType? fromJson(int index) {
    switch (index) {
      case 0:
        return incoming;
      case 1:
        return outgoing;
      default:
        return null;
    }
  }

  static AccountingInOrOutType? fromString(String type) {
    switch (type) {
      case "incoming":
        return incoming;
      case "outgoing":
        return outgoing;
      default:
        return null;
    }
  }

  int toJson() => index;
}

enum AccountingCategoryType {
  food,
  book,
  dress,
  car,
  sport,
  house,
  hobby,
  healthy,
  otherOut,
  salary,
  otherIn;

  static AccountingCategoryType? fromJson(int index) {
    switch (index) {
      case 0:
        return food;
      case 1:
        return book;
      case 2:
        return dress;
      case 3:
        return car;
      case 4:
        return sport;
      case 5:
        return house;
      case 6:
        return hobby;
      case 7:
        return healthy;
      case 8:
        return otherOut;
      case 9:
        return salary;
      case 10:
        return otherIn;
      default:
        return null;
    }
  }

  static AccountingCategoryType? fromString(String category) {
    switch (category) {
      case "food":
        return food;
      case "book":
        return book;
      case "dress":
        return dress;
      case "car":
        return car;
      case "sport":
        return sport;
      case "house":
        return house;
      case "hobby":
        return hobby;
      case "healthy":
        return healthy;
      case "otherOut":
        return otherOut;
      case "salary":
        return salary;
      case "otherIn":
        return otherIn;
      default:
        return null;
    }
  }

  int toJson() => index;
}

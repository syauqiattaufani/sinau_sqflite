class Company {
  String? id;
  String? name;
  String? value;

  Company(this.id, this.name, this.value);

  Map<String?, dynamic> toMap() {
    Map<String?, dynamic> map = Map<String?, dynamic>();
    map['id'] = this.id;
    map['name'] = this.name;
    map['value'] = this.value;
    return map;
  }
}
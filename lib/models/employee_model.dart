class EmployeeModel {
  dynamic id;
  dynamic name;
  dynamic email;
  dynamic gender;
  dynamic salaryPerMonth;
  dynamic createdOn;

  EmployeeModel(
      {this.id,
        this.name,
        this.email,
        this.gender,
        this.salaryPerMonth,
        this.createdOn});

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    salaryPerMonth = json['salary_per_month'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['salary_per_month'] = this.salaryPerMonth;
    data['created_on'] = this.createdOn;
    return data;
  }
}

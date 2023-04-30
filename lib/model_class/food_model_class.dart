

class FoodModelClass{

  String ? id;
  String ? name;
  String ? type;
  double ? price;
  String ? quantity;
  String ? imgUrl;/////////////////////////////////////////////////////////
  FoodModelClass(this.id,this.name, this.type, this.price, this.quantity);
}

  final List<FoodModelClass> food=[
    FoodModelClass('ctf1','cat','spectrum', 150,'500 gram'),
    FoodModelClass('ctf2','cat','brit', 150,'500 gram'),
    FoodModelClass('ctf3','cat','bonnie',150,'500 gram'),

    FoodModelClass('dgf1','dog','Drools',150,'500 gram'),
    FoodModelClass('dgf2','dog','royal canin',150,'500 gram'),
    FoodModelClass('dgf3','dog','bonnie',150,'500 gram'),

    FoodModelClass('bdf1','bird','quick budgie',150,'500 gram'),
    FoodModelClass('bdf2','bird','deli nature',150,'500 gram'),
    FoodModelClass('bdf3','bird','faicip',150,'500 gram'),

  ];
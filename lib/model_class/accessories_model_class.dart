


 class AccessoriesModelClass{
  String ? id;
  String ? name;
  String ? type;
  double ? price;
  String ? imgUrl;////////////////////////////////////////////////////////

  AccessoriesModelClass(this.id, this.name, this.type, this.price);
}

 final List<AccessoriesModelClass> accessory=[
  AccessoriesModelClass('cta1','food bowl', 'cat',50),
  AccessoriesModelClass('cta2','scratcher', 'cat',50),
  AccessoriesModelClass('cta3','litter tray', 'cat',50),

  AccessoriesModelClass('dga1','paw cleaner', 'dog',50),
  AccessoriesModelClass('dga2','collar', 'dog',50),
  AccessoriesModelClass('dga3','toy', 'dog',50),

  AccessoriesModelClass('bda1','cage', 'bird',50),
  AccessoriesModelClass('bda2','water filter', 'bird',50),
  AccessoriesModelClass('dda3','leg ring', 'bird',50),
 ];
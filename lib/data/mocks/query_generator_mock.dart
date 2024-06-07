const queryGeneratorMock = [
  'CREATE TABLE IF NOT EXISTS event (idEvent INTEGER PRIMARY KEY, name TEXT, date TEXT, time TEXT, deleted TEXT)',
  'CREATE TABLE IF NOT EXISTS category (idCategory INTEGER PRIMARY KEY, type TEXT, deleted TEXT)',
  'CREATE TABLE IF NOT EXISTS product (idProduct INTEGER PRIMARY KEY, idCategory INTEGER, name TEXT, type TEXT, value REAL, deleted TEXT, FOREIGN KEY (idCategory) REFERENCES category(idCategory))',
  'CREATE TABLE IF NOT EXISTS option (idOption INTEGER PRIMARY KEY, idProduct INTEGER, name TEXT, quantity INTEGER, deleted TEXT, FOREIGN KEY (idProduct) REFERENCES product(idProduct))',
  'CREATE TABLE IF NOT EXISTS ordered (idOrdered INTEGER PRIMARY KEY, idEvent INTEGER, valueTotal REAL, FOREIGN KEY (idEvent) REFERENCES event(idEvent))',
  'CREATE TABLE IF NOT EXISTS orderedItem (idOrderedItem INTEGER PRIMARY KEY, idOrdered INTEGER, idProduct INTEGER, valueItem REAL, quantity INTEGER, FOREIGN KEY (idOrdered) REFERENCES ordered(idOrdered))',
];

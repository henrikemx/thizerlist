String dbName = 'thizerlist.db';
int dbVersion = 1;

List<String> dbCreate = [
  // tb lista
  """CREATE TABLE lista (
    pk_lista INTEGER PRIMARY KEY,
    name TEXT,
    created TEXT
  )""",

  // tb Item
  """CREATE TABLE item (
    pk_item INTEGER PRIMARY KEY,
    fk_lista INTEGER,
    name TEXT,
    qtde DECIMAL(10,3),
    valor DECIMAL(10,2),
    created TEXT
  )"""  
];
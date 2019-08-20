package Moodle::Library;

use Data::Object 'Library';

our $Migrator = declare "Migrator",
  as InstanceOf["Doodle::Migrator"];

our $MysqlDriver = declare "MysqlDriver",
  as InstanceOf["Mojo::mysql"];

our $PostgresDriver = declare "PostgresDriver",
  as InstanceOf["Mojo::Pg"];

our $SqliteDriver = declare "SqliteDriver",
  as InstanceOf["Mojo::SQLite"];

our $Driver = declare "Driver",
  as $MysqlDriver | $PostgresDriver | $SqliteDriver;

1;

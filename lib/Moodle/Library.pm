package Moodle::Library;

use 5.014;

use Data::Object 'Library';

# VERSION

our $MysqlDriver = declare "MysqlDriver",
  as InstanceOf["Mojo::mysql"];

our $PostgresDriver = declare "PostgresDriver",
  as InstanceOf["Mojo::Pg"];

our $SqliteDriver = declare "SqliteDriver",
  as InstanceOf["Mojo::SQLite"];

our $Driver = declare "Driver",
  as $MysqlDriver | $PostgresDriver | $SqliteDriver;

our $Migrator = declare "Migrator",
  as InstanceOf["Doodle::Migration"];

1;

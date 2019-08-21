package Moodle;

use 5.014;

use Data::Object 'Class', 'Moodle::Library';

use Carp;

# VERSION

has driver => (
  is => 'ro',
  isa => 'Driver',
  req => 1
);

has migrator => (
  is => 'ro',
  isa => 'Migrator',
  req => 1
);

# METHODS

method content() {
  my $grammar;

  my $driver = $self->driver;
  my $migrator = $self->migrator;

  if ($driver->isa('Mojo::Pg')) {
    $grammar = 'postgres';
  }
  if ($driver->isa('Mojo::SQLite')) {
    $grammar = 'sqlite';
  }
  if ($driver->isa('Mojo::mysql')) {
    $grammar = 'mysql';
  }

  my @sql;

  my $statements = $migrator->statements($grammar);

  for (my $i = 0; $i < @$statements; $i++) {
    my $up_note = "-- @{[$i+1]} up";
    my $up_text = join "\n", map "$_;", @{$statements->[$i][0]};

    push @sql, $up_note, $up_text;

    my $dn_note = "-- @{[$i+1]} down";
    my $dn_text = join "\n", map "$_;", @{$statements->[$i][1]};

    push @sql, $dn_note, $dn_text;
  }

  return join "\n", @sql;
}

method migrate(Maybe[Str] $target) {
  my $driver = $self->driver;
  my $content = $self->content;

  return $driver->migrations->from_string($content)->migrate($target);
}

1;

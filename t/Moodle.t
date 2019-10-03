use 5.014;

use Do;
use Test::Auto;
use Test::More;

=name

Moodle

=cut

=abstract

Mojo DB Driver Migrations

=cut

=includes

method: content
method: migrate

=cut

=synopsis

  # migration: step #1

  package Migration::Step1;

  use parent 'Doodle::Migration';

  no warnings 'redefine';

  sub up {
    my ($self, $doodle) = @_;

    my $table = $doodle->table('users');
    $table->primary('id');
    $table->create;

    return $doodle;
  }

  sub down {
    my ($self, $doodle) = @_;

    my $table = $doodle->table('users');
    $table->delete;

    return $doodle;
  }

  # migration: step #2

  package Migration::Step2;

  use parent 'Doodle::Migration';

  no warnings 'redefine';

  sub up {
    my ($self, $doodle) = @_;

    my $table = $doodle->table('users');
    $table->string('email')->create;

    return $doodle;
  }

  sub down {
    my ($self, $doodle) = @_;

    my $table = $doodle->table('users');
    $table->string('email')->delete;

    return $doodle;
  }

  # migration: root

  package Migration;

  use parent 'Doodle::Migration';

  sub migrations {[
    'Migration::Step1',
    'Migration::Step2',
  ]}

  # main program

  package main;

  use Moodle;

  my $self = Moodle->new(
    driver => $main::driver,
    migrator => Migration->new
  );

  # $self->migrate;

=cut

=libraries

Moodle::Library

=cut

=attributes

driver: ro, req, Driver
migrator: ro, req, Migrator

=cut

=description

This package uses L<Doodle> with L<Mojo> database drivers to easily install and
evolve database schema migrations. See L<Doodle::Migration> for help setting up
L<Doodle> migrations, and L<Mojo::Pg>, L<Mojo::mysql> or L<Mojo::SQLite> for
help configuring DB drivers.

=cut

=method content

This method generates DB migration statements returning a string containing
"UP" and "DOWN" versioned migration strings suitable for use with the migration
feature of Mojo database drivers.

=signature content

content() : Str

=example-1 content

  # given: synopsis

  my $content = $self->content;

=method migrate

This method uses the DB migration statements generated by the L</content>
method and installs them using the Mojo database driver. This method returns a
migration object relative to the DB driver used.

=signature migrate

migrate(Maybe[Str] $target) : Object

=example-1 migrate

  # given: synopsis

  my $migrate = $self->migrate;

=cut

package main;

our $driver;

if ($ENV{TEST_MOJOPG} && eval { require Mojo::Pg }) {
  $driver = Mojo::Pg->new($ENV{TEST_MOJOPG});
}

if ($ENV{TEST_MOJOMYSQL} && eval { require Mojo::mysql }) {
  $driver = Mojo::mysql->new($ENV{TEST_MOJOMYSQL});
}

if ($ENV{TEST_MOJOSQLITE} && eval { require Mojo::SQLite }) {
  $driver = Mojo::SQLite->new($ENV{TEST_MOJOSQLITE});
}

my $test = Test::Auto->new(__FILE__);

my $subtests = $test->subtests->standard;

SKIP: {
  skip 'No DB driver configured, e.g. TEST_MOJOSQLITE=sqlite:test.db'
    unless $driver;

  $subtests->synopsis(fun($tryable) {
    ok my $result = $tryable->result, 'result ok';

    $result;
  });

  $subtests->example(-1, 'content', 'method', fun($tryable) {
    ok my $result = $tryable->result, 'result ok';

    like $result, qr/-- 1 up/;
    like $result, qr/create table .users./;

    like $result, qr/-- 1 down/;
    like $result, qr/drop table .users./;

    like $result, qr/-- 2 up/;
    like $result, qr/alter table .users. add column .email. varchar/;

    like $result, qr/-- 2 down/;
    like $result, qr/alter table .users. drop column .email./;

    $result;
  });

  $subtests->example(-1, 'migrate', 'method', fun($tryable) {
    ok my $result = $tryable->result, 'result ok';

    $result;
  });
}

ok 1 and done_testing;

use 5.014;

use strict;
use warnings;

use Test::More;

=name

Moodle

=abstract

Nam suscipit iaculis magna vitae faucibus.

=synopsis

  use Moodle;

  my $self = Moodle->new;

=description

Moodle use L<Doodle> with L<Mojo> database drivers to easily install and evolve database schema migrations.

=cut

use_ok "Moodle";

ok 1 and done_testing;

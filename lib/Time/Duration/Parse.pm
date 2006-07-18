package Time::Duration::Parse;

use strict;
our $VERSION = '0.01';

use Carp;
use Exporter::Lite;
our @EXPORT = qw( parse_duration );

# This map is taken from Cache and Cache::Cache
# map of expiration formats to their respective time in seconds
my %_Expiration_Units = ( map(($_,             1), qw(s second seconds sec)),
                          map(($_,            60), qw(m minute minutes min)),
                          map(($_,         60*60), qw(h hour hours)),
                          map(($_,      60*60*24), qw(d day days)),
                          map(($_,    60*60*24*7), qw(w week weeks)),
                          map(($_,   60*60*24*30), qw(M month months)),
                          map(($_,  60*60*24*365), qw(y year years)) );

# aren't there any CPAN module that does this?
sub parse_duration {
    my $timespec = shift;

    my $duration = 0;
    while ($timespec =~ s/^\s*(\d+)\s+(\w+)(?:\s*(?:,|and)\s*)*//i) {
        if (my $unit = $_Expiration_Units{$2}) {
            $duration += $1 * $unit;
        } else {
            Carp::croak "Unknown timespec: $1 $2";
        }
    }

    if ($timespec) {
        Carp::croak "timespec with cruft leftover: $timespec";
    }

    return $duration;
}


1;
__END__

=head1 NAME

Time::Duration::Parse - Parse string that represents time duration

=head1 SYNOPSIS

  use Time::Duration::Parse;

  my $seconds = parse_duration("2 minutes and 3 seconds"); # 123

=head1 DESCRIPTION

Time::Duration::Parse is a module to parse human readable duration
strings like I<2 minutes and 3 seconds> to seconds.

It does the opposite of I<duration_exact> function in Time::Duration
and is roundtrip safe. So, the following is always true.

  use Time::Duration::Parse;
  use Time::Duration;

  my $seconds = int rand 100000;
  is( parse_duration(duration_exact($seconds)), $seconds );

=head1 FUNCTIONS

=over 4

=item parse_duration

  $seconds = parse_duration($string);

Parses duration string and returns seconds. When it encounters an
error in a given string, it dies an exception saying:

=over 8

=item Unknown timespec: %d %s

=item timespec with cruft leftover: %s

=back

=head1 AUTHOR

Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

=head1 COPYRIGHT

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

Some internal code is taken from Cache and Cache::Cache modules on
CPAN.

=head1 SEE ALSO

L<Date::Manip>, L<http://use.perl.org/~miyagawa/journal/30310>

=cut

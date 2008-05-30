use strict;
use Test::More tests => 37;

use Time::Duration::Parse;

sub ok_duration {
    my($spec, $seconds) = @_;
    is parse_duration($spec), $seconds, "$spec = $seconds";
}

sub fail_duration {
    my $spec = shift;
    eval { parse_duration($spec) };
    ok $@, $@;
}

ok_duration '3', 3;
ok_duration '3 seconds', 3;
ok_duration '3 Seconds', 3;
ok_duration '3 s', 3;
ok_duration '6 minutes', 360;
ok_duration '6 minutes and 3 seconds', 363;
ok_duration '6 Minutes and 3 seconds', 363;
ok_duration '1 day', 86400;
ok_duration '1 day, and 3 seconds', 86403;
ok_duration '-1 seconds', -1;
ok_duration '-6 minutes', -360;

ok_duration '1 hr', 3600;
ok_duration '3s', 3;
ok_duration '1hr', 3600;

ok_duration '1d 2:03', 93780;
ok_duration '1d 2:03:01', 93781;
ok_duration '1d -24:00', 0;
ok_duration '2:03', 7380;

ok_duration ' 1s   ', 1;
ok_duration '   1  ', 1;
ok_duration '  1.3 ', 1;

ok_duration '1.5h', 5400;
ok_duration '1,5h', 5400;
ok_duration '1.5h 30m', 7200;
ok_duration '1.9s', 2;          # Check rounding
ok_duration '1.3s', 1;
ok_duration '1.3', 1;
ok_duration '1.9', 2;

ok_duration '1h,30m, 3s', 5403;
ok_duration '1h and 30m,3s', 5403;
ok_duration '1,5h, 3s', 5403;
ok_duration '1,5h and 3s', 5403;
ok_duration '1.5h, 3s', 5403;
ok_duration '1.5h and 3s', 5403;

fail_duration '3 sss';
fail_duration '6 minutes and 3 sss';
fail_duration '6 minutes, and 3 seconds a';

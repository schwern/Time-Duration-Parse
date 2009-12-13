use strict;
use Test::More tests => 17;

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

fail_duration '3 sss';
fail_duration '6 minutes and 3 sss';
fail_duration '6 minutes, and 3 seconds a';

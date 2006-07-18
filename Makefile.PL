use inc::Module::Install;

name('Time-Duration-Parse');
all_from('lib/Time/Duration/Parse.pm');

requires('Exporter::Lite');
build_requires('Test::More');
build_requires('Time::Duration');

auto_include;
WriteAll;

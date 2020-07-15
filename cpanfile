requires "Carp" => "0";
requires "Exporter" => "0";
requires "Moo" => "0";
requires "Moo::Role" => "0";
requires "Try::Tiny" => "0";
requires "Scalar::Util" => "0";
requires "autodie" => "0";
requires "base" => "0";
requires "perl" => "5.006";
requires "strictures" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "Test::More" => "0";
  requires "Test::Pod" => "1.41";
  requires "Pod::Coverage" => "0.20";
  requires "Test::Pod::Coverage" => "1.04";
};

on 'configure' => sub {
  requires "Module::Build::Tiny" => "0.034";
};

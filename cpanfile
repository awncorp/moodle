requires "Data::Object" => "0.99";
requires "Doodle" => "0.05";
requires "perl" => "5.014";

on 'test' => sub {
  requires "Data::Object" => "0.99";
  requires "Doodle" => "0.05";
  requires "perl" => "5.014";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

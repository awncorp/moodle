requires "Do" => "1.87";
requires "Doodle" => "0.06";
requires "perl" => "5.014";

on 'test' => sub {
  requires "Do" => "1.87";
  requires "Doodle" => "0.06";
  requires "Test::Auto" => "0.03";
  requires "perl" => "5.014";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

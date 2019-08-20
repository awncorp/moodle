requires "Data::Object" => "0.99";

on 'test' => sub {
  requires "Data::Object" => "0.99";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

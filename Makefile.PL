
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t t/9bug/*.t'
                                 },
                       'NAME' => 'Google::Search',
                       'DISTNAME' => 'Google-Search',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Robert Krimen <robertkrimen@gmail.com>',
                       'BUILD_REQUIRES' => {
                                             'Test::Most' => '0'
                                           },
                       'ABSTRACT' => 'Interface to the Google AJAX Search API and suggestion API',
                       'EXE_FILES' => [],
                       'VERSION' => '0.027',
                       'PREREQ_PM' => {
                                        'Try::Tiny' => '0',
                                        'URI' => '0',
                                        'LWP::UserAgent' => '0',
                                        'Carp::Clan::Share' => '0',
                                        'Any::Moose' => '0',
                                        'JSON' => '2'
                                      },
                       'LICENSE' => 'perl'
                     );


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM}; 
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod}; 
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);




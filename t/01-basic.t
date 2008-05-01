use Test::More;

use Google::Search;

#plan skip_all => "Do TEST_RELEASE=1 to go out to Google and run some tests" unless $ENV{TEST_RELEASE};
plan qw/no_plan/;

my $referer = "http://search.cpan.org/~rkrimen/";
my $key = "ABQIAAAAtDqLrYRkXZ61bOjIaaXZyxQRY_BHZpnLMrZfJ9KcaAuQJCJzjxRJoUJ6qIwpBfxHzBbzHItQ1J7i0w";

ok(Google::Search->$_(q => { q => "$_" })) for qw/Web Local Video Image Book News/;
my $search = Google::Search->Web(q => "rock");
ok($search);

SKIP: {
    skip "Do TEST_RELEASE=1 to go out to Google and run some tests" unless $ENV{TEST_RELEASE};
    my $search = Google::Search->Web(referer => $referer, key => $key, q => { q => "rock" });
    ok($search);
    ok($search->first) || diag $search->error->http_response->as_string;
    ok($search->result(27)) || diag $search->error->http_response->as_string;
    ok(!$search->result(28));
    my $error = $search->error;
    ok($error);
    is($error->code, 400);
    is($error->message, "out of range start");
    ok($error->http_response);
    is($error->http_response->status_line, "200 OK");

    my $count = 0;
    while (my $result = $search->next) {
        is($result->number, $count);
        ok($result->uri);
        ok($result);
        $count += 1;
    }
    is($count, 28);

    is(scalar @{ $search->all }, 28);
    is(scalar $search->match(sub { 1 }), 28);
    is($search->first_match(sub { 1 }), $search->first);
    is($search->first_match(sub { shift->number eq 27 }), $search->result(27));
}

1;
use strict;
use warnings;
use DBIx::Sunny;

my $db = DBIx::Sunny->connect(
    'dbi:mysql:database=isucon5q;host=localhost;port=3306', 'root', ''
);

my $comment_id = 0;

while (1) {
    warn "id > $comment_id ...";

    my $comments = $db->select_all(
        'SELECT comments.id AS comment_id, entries.user_id AS owner_id FROM comments JOIN entries ON entry_id = entries.id WHERE comments.id > ? LIMIT 5000', $comment_id
    );
    if (@$comments == 0) {
        last;
    }

    for my $c (@$comments) {
        $db->query(
            'UPDATE comments SET owner_id = ? WHERE id = ?',
            $c->{owner_id},
            $c->{comment_id},
        );
    }

    $comment_id = $comments->[-1]->{id};
}

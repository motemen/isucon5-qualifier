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
        'SELECT id,entry_id FROM comments WHERE owner_id = 0 AND id > ? ORDER BY id ASC LIMIT 10000',
        $comment_id,
    );
    if (@$comments == 0) {
        last;
    }

    my $entries = $db->select_all(
        'SELECT id,user_id FROM entries WHERE id IN (?)',
        [ map { $_->{entry_id} } @$comments ],
    );
    my $owner_id_by_entry_id = +{
        map { +( $_->{id} => $_->{user_id} ) } @$entries
    };

    for my $c (@$comments) {
        $db->query(
            'UPDATE comments SET owner_id = ? WHERE id = ?',
            $owner_id_by_entry_id->{$c->{entry_id}},
            $c->{id},
        );
    }

    $comment_id = $comments->[-1]->{id};
}

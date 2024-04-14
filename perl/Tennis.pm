use 5.38.0;
use Object::Pad 0.808 qw( :experimental(inherit_field) );

class Tennis::Player {

    field $name   :reader :param;
    field $points :reader = 0;

    method increment_points () { $points++ };

};

class Tennis::Score {

    field $player_1 :param;
    field $player_2 :param;

    method to_string () {
        if (($player_1->points < 4 && $player_2->points < 4) && ($player_1->points + $player_2->points < 6)) {
            my @p = ("Love", "Fifteen", "Thirty", "Forty");
            my $s = $p[$player_1->points];
            $player_1->points == $player_2->points ? "$s-All" : $s . "-" . $p[$player_2->points];
        }
        else {
            return "Deuce" if ($player_1->points == $player_2->points);
            my $s = $player_1->points > $player_2->points ? $player_1->name : $player_2->name;
            (($player_1->points - $player_2->points) * ($player_1->points - $player_2->points) == 1) ? "Advantage $s" : "Win for $s";
        }
    };

};

class Tennis::Game {

    field $player_1 :reader;
    field $player_2 :reader;

    BUILD (@playerNames) {
        ($player_1, $player_2) = map Tennis::Player->new(name => $_), @playerNames;
    };

    method won_point ($playerName) {
        if ($playerName eq $player_1->name) {
            $player_1->increment_points;
        }
        else {
            $player_2->increment_points;
        }
    }

    method score () {
        my $score = Tennis::Score->new(
            player_1 => $player_1,
            player_2 => $player_2,
        );
        return $score->to_string;
    }

};

1;

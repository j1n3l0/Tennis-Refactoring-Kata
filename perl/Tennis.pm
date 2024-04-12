use 5.38.0;
use Object::Pad 0.808 qw( :experimental(inherit_field) );

class Tennis::Player {

    field $name   :reader :param;
    field $points :reader = 0;

    method increment_points () { $points++ };

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
        if (($self->player_1->points < 4 && $self->player_2->points < 4) && ($self->player_1->points + $self->player_2->points < 6)) {
            my @p = ("Love", "Fifteen", "Thirty", "Forty");
            my $s = $p[$self->player_1->points];
            $self->player_1->points == $self->player_2->points ? "$s-All" : $s . "-" . $p[$self->player_2->points];
        }
        else {
            return "Deuce" if ($self->player_1->points == $self->player_2->points);
            my $s = $self->player_1->points > $self->player_2->points ? $self->player_1->name : $self->player_2->name;
            (($self->player_1->points - $self->player_2->points) * ($self->player_1->points - $self->player_2->points) == 1) ? "Advantage $s" : "Win for $s";
        }
    }

};


class Tennis::Game1 :isa(Tennis::Game) {};

class Tennis::Game2 :isa(Tennis::Game) {};

class Tennis::Game3 :isa(Tennis::Game) {};

1;

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

};


class Tennis::Game1 :isa(Tennis::Game) {

    method score () {
        my $result    = "";
        my $tempScore = 0;

        if ($self->player_1->points == $self->player_2->points) {
            $result = {
                0 => "Love-All",
                1 => "Fifteen-All",
                2 => "Thirty-All",
            }->{ $self->player_1->points }
                || "Deuce";
        }

        elsif ($self->player_1->points >= 4 or $self->player_2->points >= 4) {
            my $minusResult = $self->player_1->points - $self->player_2->points;
            if ($minusResult == 1) {
                $result = "Advantage " . $self->player_1->name;
            }
            elsif ($minusResult == -1) {
                $result = "Advantage " . $self->player_2->name;
            }
            elsif ($minusResult >= 2) {
                $result = "Win for " . $self->player_1->name;
            }
            else {
                $result = "Win for " . $self->player_2->name;
            }
        }

        else {
            foreach my $i (1 .. 2) {
                if ($i == 1) {
                    $tempScore = $self->player_1->points;
                }
                else {
                    $result .= "-";
                    $tempScore = $self->player_2->points;
                }

                $result .= {
                    0 => "Love",
                    1 => "Fifteen",
                    2 => "Thirty",
                    3 => "Forty",
                }->{$tempScore};
            }
        }

        return $result;
    }

};

class Tennis::Game2 :isa(Tennis::Game) {

    method score () {
        my $result = "";
        if ($self->player_1->points == $self->player_2->points && $self->player_1->points < 3) {
            if ($self->player_1->points == 0) {
                $result = "Love";
            }
            if ($self->player_1->points == 1) {
                $result = "Fifteen";
            }
            if ($self->player_1->points == 2) {
                $result = "Thirty";
            }
            $result .= "-All";
        }
        if ($self->player_1->points == $self->player_2->points and $self->player_1->points > 2) {
            $result = "Deuce";
        }

        my $P1res = "";
        my $P2res = "";
        if ($self->player_1->points > 0 && $self->player_2->points == 0) {
            if ($self->player_1->points == 1) {
                $P1res = "Fifteen";
            }
            if ($self->player_1->points == 2) {
                $P1res = "Thirty";
            }
            if ($self->player_1->points == 3) {
                $P1res = "Forty";
            }

            $P2res  = "Love";
            $result = "$P1res-$P2res";
        }
        if ($self->player_2->points > 0 && $self->player_1->points == 0) {
            if ($self->player_2->points == 1) {
                $P2res = "Fifteen";
            }
            if ($self->player_2->points == 2) {
                $P2res = "Thirty";
            }
            if ($self->player_2->points == 3) {
                $P2res = "Forty";
            }
            $P1res  = "Love";
            $result = "$P1res-$P2res";
        }

        if ($self->player_1->points > $self->player_2->points && $self->player_1->points < 4) {
            if ($self->player_1->points == 2) {
                $P1res = "Thirty";
            }
            if ($self->player_1->points == 3) {
                $P1res = "Forty";
            }
            if ($self->player_2->points == 1) {
                $P2res = "Fifteen";
            }
            if ($self->player_2->points == 2) {
                $P2res = "Thirty";
            }
            $result = "$P1res-$P2res";
        }
        if ($self->player_2->points > $self->player_1->points && $self->player_2->points < 4) {
            if ($self->player_2->points == 2) {
                $P2res = "Thirty";
            }
            if ($self->player_2->points == 3) {
                $P2res = "Forty";
            }
            if ($self->player_1->points == 1) {
                $P1res = "Fifteen";
            }
            if ($self->player_1->points == 2) {
                $P1res = "Thirty";
            }
            $result = "$P1res-$P2res";
        }

        if ($self->player_1->points > $self->player_2->points && $self->player_2->points >= 3) {
            $result = "Advantage " . $self->player_1->name;
        }
        if ($self->player_2->points > $self->player_1->points && $self->player_1->points >= 3) {
            $result = "Advantage " . $self->player_2->name;
        }

        if (   $self->player_1->points >= 4
            && $self->player_2->points >= 0
            && ($self->player_1->points - $self->player_2->points) >= 2)
        {
            $result = "Win for " . $self->player_1->name;
        }
        if (   $self->player_2->points >= 4
            && $self->player_1->points >= 0
            && ($self->player_2->points - $self->player_1->points) >= 2)
        {
            $result = "Win for " . $self->player_2->name;
        }
        return $result;
    }

    method SetP1Score ($number) {
        for (0 .. $number) {
            $self->P1Score();
        }
    }

    method SetP2Score ($number) {
        for (0 .. $number) {
            $self->P2Score();
        }
    }

    method P1Score () {
        $self->player_1->points += 1;
    }

    method P2Score () {
        $self->player_2->points += 1;
    }

};

class Tennis::Game3 :isa(Tennis::Game) {

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

1;

use 5.38.0;
use Object::Pad 0.808;

class Tennis::Game1 :repr(HASH) {

    sub new ($cls, $player1Name, $player2Name) {
        my $self = {
            player1Name => $player1Name,
            player2Name => $player2Name,
            p1points    => 0,
            p2points    => 0,
        };
        return bless $self, $cls;
    }

    sub won_point ($self, $playerName) {
        if ($playerName eq $self->{player1Name}) {
            $self->{p1points}++;
        }
        else {
            $self->{p2points}++;
        }
    }

    sub score ($self) {
        my $result    = "";
        my $tempScore = 0;

        if ($self->{p1points} == $self->{p2points}) {
            $result = {
                0 => "Love-All",
                1 => "Fifteen-All",
                2 => "Thirty-All",
            }->{ $self->{p1points} }
                || "Deuce";
        }

        elsif ($self->{p1points} >= 4 or $self->{p2points} >= 4) {
            my $minusResult = $self->{p1points} - $self->{p2points};
            if ($minusResult == 1) {
                $result = "Advantage " . $self->{player1Name};
            }
            elsif ($minusResult == -1) {
                $result = "Advantage " . $self->{player2Name};
            }
            elsif ($minusResult >= 2) {
                $result = "Win for " . $self->{player1Name};
            }
            else {
                $result = "Win for " . $self->{player2Name};
            }
        }

        else {
            foreach my $i (1 .. 2) {
                if ($i == 1) {
                    $tempScore = $self->{p1points};
                }
                else {
                    $result .= "-";
                    $tempScore = $self->{p2points};
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

class Tennis::Game2 :repr(HASH) {

    sub new ($cls, $player1Name, $player2Name) {
        my $self = {
            player1Name => $player1Name,
            player2Name => $player2Name,
            p1points    => 0,
            p2points    => 0,
        };
        return bless $self, $cls;
    }

    sub won_point ($self, $playerName) {
        if ($playerName eq $self->{player1Name}) {
            $self->{p1points}++;
        }
        else {
            $self->{p2points}++;
        }
    }

    sub score ($self) {
        my $result = "";
        if ($self->{p1points} == $self->{p2points} && $self->{p1points} < 3) {
            if ($self->{p1points} == 0) {
                $result = "Love";
            }
            if ($self->{p1points} == 1) {
                $result = "Fifteen";
            }
            if ($self->{p1points} == 2) {
                $result = "Thirty";
            }
            $result .= "-All";
        }
        if ($self->{p1points} == $self->{p2points} and $self->{p1points} > 2) {
            $result = "Deuce";
        }

        my $P1res = "";
        my $P2res = "";
        if ($self->{p1points} > 0 && $self->{p2points} == 0) {
            if ($self->{p1points} == 1) {
                $P1res = "Fifteen";
            }
            if ($self->{p1points} == 2) {
                $P1res = "Thirty";
            }
            if ($self->{p1points} == 3) {
                $P1res = "Forty";
            }

            $P2res  = "Love";
            $result = "$P1res-$P2res";
        }
        if ($self->{p2points} > 0 && $self->{p1points} == 0) {
            if ($self->{p2points} == 1) {
                $P2res = "Fifteen";
            }
            if ($self->{p2points} == 2) {
                $P2res = "Thirty";
            }
            if ($self->{p2points} == 3) {
                $P2res = "Forty";
            }
            $P1res  = "Love";
            $result = "$P1res-$P2res";
        }

        if ($self->{p1points} > $self->{p2points} && $self->{p1points} < 4) {
            if ($self->{p1points} == 2) {
                $P1res = "Thirty";
            }
            if ($self->{p1points} == 3) {
                $P1res = "Forty";
            }
            if ($self->{p2points} == 1) {
                $P2res = "Fifteen";
            }
            if ($self->{p2points} == 2) {
                $P2res = "Thirty";
            }
            $result = "$P1res-$P2res";
        }
        if ($self->{p2points} > $self->{p1points} && $self->{p2points} < 4) {
            if ($self->{p2points} == 2) {
                $P2res = "Thirty";
            }
            if ($self->{p2points} == 3) {
                $P2res = "Forty";
            }
            if ($self->{p1points} == 1) {
                $P1res = "Fifteen";
            }
            if ($self->{p1points} == 2) {
                $P1res = "Thirty";
            }
            $result = "$P1res-$P2res";
        }

        if ($self->{p1points} > $self->{p2points} && $self->{p2points} >= 3) {
            $result = "Advantage " . $self->{player1Name};
        }
        if ($self->{p2points} > $self->{p1points} && $self->{p1points} >= 3) {
            $result = "Advantage " . $self->{player2Name};
        }

        if (   $self->{p1points} >= 4
            && $self->{p2points} >= 0
            && ($self->{p1points} - $self->{p2points}) >= 2)
        {
            $result = "Win for " . $self->{player1Name};
        }
        if (   $self->{p2points} >= 4
            && $self->{p1points} >= 0
            && ($self->{p2points} - $self->{p1points}) >= 2)
        {
            $result = "Win for " . $self->{player2Name};
        }
        return $result;
    }

    sub SetP1Score ($self, $number) {
        for (0 .. $number) {
            $self->P1Score();
        }
    }

    sub SetP2Score ($self, $number) {
        for (0 .. $number) {
            $self->P2Score();
        }
    }

    sub P1Score ($self) {
        $self->{p1points} += 1;
    }

    sub P2Score ($self) {
        $self->{p2points} += 1;
    }

};

class Tennis::Game3 :repr(HASH) {

    sub new ($cls, $player1Name, $player2Name) {
        my $self = {
            player1Name => $player1Name,
            player2Name => $player2Name,
            p1points    => 0,
            p2points    => 0,
        };
        return bless $self, $cls;
    }

    sub won_point ($self, $playerName) {
        if ($playerName eq $self->{player1Name}) {
            $self->{p1points}++;
        }
        else {
            $self->{p2points}++;
        }
    }

    sub score ($self) {
        my ($p1points, $p2points) = @$self{ "p1points", "p2points" };

        if (($p1points < 4 && $p2points < 4) && ($p1points + $p2points < 6)) {
            my @p = ("Love", "Fifteen", "Thirty", "Forty");
            my $s = $p[$p1points];
            $p1points == $p2points ? "$s-All" : $s . "-" . $p[$p2points];
        }
        else {
            return "Deuce" if ($p1points == $p2points);
            my $s = $p1points > $p2points ? $self->{player1Name} : $self->{player2Name};
            (($p1points - $p2points) * ($p1points - $p2points) == 1) ? "Advantage $s" : "Win for $s";
        }
    }

};

1;

use 5.38.0;
use Object::Pad 0.808;

class Tennis::Game1 {

    field $player1Name;
    field $player2Name;
    field $p1points = 0;
    field $p2points = 0;

    BUILD (@playerNames) { ($player1Name, $player2Name) = @playerNames };

    method won_point ($playerName) {
        if ($playerName eq $player1Name) {
            $p1points++;
        }
        else {
            $p2points++;
        }
    }

    method score () {
        my $result    = "";
        my $tempScore = 0;

        if ($p1points == $p2points) {
            $result = {
                0 => "Love-All",
                1 => "Fifteen-All",
                2 => "Thirty-All",
            }->{ $p1points }
                || "Deuce";
        }

        elsif ($p1points >= 4 or $p2points >= 4) {
            my $minusResult = $p1points - $p2points;
            if ($minusResult == 1) {
                $result = "Advantage " . $player1Name;
            }
            elsif ($minusResult == -1) {
                $result = "Advantage " . $player2Name;
            }
            elsif ($minusResult >= 2) {
                $result = "Win for " . $player1Name;
            }
            else {
                $result = "Win for " . $player2Name;
            }
        }

        else {
            foreach my $i (1 .. 2) {
                if ($i == 1) {
                    $tempScore = $p1points;
                }
                else {
                    $result .= "-";
                    $tempScore = $p2points;
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

class Tennis::Game2 {

    field $player1Name;
    field $player2Name;
    field $p1points = 0;
    field $p2points = 0;

    BUILD (@playerNames) { ($player1Name, $player2Name) = @playerNames };

    method won_point ($playerName) {
        if ($playerName eq $player1Name) {
            $p1points++;
        }
        else {
            $p2points++;
        }
    }

    method score () {
        my $result = "";
        if ($p1points == $p2points && $p1points < 3) {
            if ($p1points == 0) {
                $result = "Love";
            }
            if ($p1points == 1) {
                $result = "Fifteen";
            }
            if ($p1points == 2) {
                $result = "Thirty";
            }
            $result .= "-All";
        }
        if ($p1points == $p2points and $p1points > 2) {
            $result = "Deuce";
        }

        my $P1res = "";
        my $P2res = "";
        if ($p1points > 0 && $p2points == 0) {
            if ($p1points == 1) {
                $P1res = "Fifteen";
            }
            if ($p1points == 2) {
                $P1res = "Thirty";
            }
            if ($p1points == 3) {
                $P1res = "Forty";
            }

            $P2res  = "Love";
            $result = "$P1res-$P2res";
        }
        if ($p2points > 0 && $p1points == 0) {
            if ($p2points == 1) {
                $P2res = "Fifteen";
            }
            if ($p2points == 2) {
                $P2res = "Thirty";
            }
            if ($p2points == 3) {
                $P2res = "Forty";
            }
            $P1res  = "Love";
            $result = "$P1res-$P2res";
        }

        if ($p1points > $p2points && $p1points < 4) {
            if ($p1points == 2) {
                $P1res = "Thirty";
            }
            if ($p1points == 3) {
                $P1res = "Forty";
            }
            if ($p2points == 1) {
                $P2res = "Fifteen";
            }
            if ($p2points == 2) {
                $P2res = "Thirty";
            }
            $result = "$P1res-$P2res";
        }
        if ($p2points > $p1points && $p2points < 4) {
            if ($p2points == 2) {
                $P2res = "Thirty";
            }
            if ($p2points == 3) {
                $P2res = "Forty";
            }
            if ($p1points == 1) {
                $P1res = "Fifteen";
            }
            if ($p1points == 2) {
                $P1res = "Thirty";
            }
            $result = "$P1res-$P2res";
        }

        if ($p1points > $p2points && $p2points >= 3) {
            $result = "Advantage " . $player1Name;
        }
        if ($p2points > $p1points && $p1points >= 3) {
            $result = "Advantage " . $player2Name;
        }

        if (   $p1points >= 4
            && $p2points >= 0
            && ($p1points - $p2points) >= 2)
        {
            $result = "Win for " . $player1Name;
        }
        if (   $p2points >= 4
            && $p1points >= 0
            && ($p2points - $p1points) >= 2)
        {
            $result = "Win for " . $player2Name;
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
        $p1points += 1;
    }

    method P2Score () {
        $p2points += 1;
    }

};

class Tennis::Game3 {

    field $player1Name;
    field $player2Name;
    field $p1points = 0;
    field $p2points = 0;

    BUILD (@playerNames) { ($player1Name, $player2Name) = @playerNames };

    method won_point ($playerName) {
        if ($playerName eq $player1Name) {
            $p1points++;
        }
        else {
            $p2points++;
        }
    }

    method score () {
        if (($p1points < 4 && $p2points < 4) && ($p1points + $p2points < 6)) {
            my @p = ("Love", "Fifteen", "Thirty", "Forty");
            my $s = $p[$p1points];
            $p1points == $p2points ? "$s-All" : $s . "-" . $p[$p2points];
        }
        else {
            return "Deuce" if ($p1points == $p2points);
            my $s = $p1points > $p2points ? $player1Name : $player2Name;
            (($p1points - $p2points) * ($p1points - $p2points) == 1) ? "Advantage $s" : "Win for $s";
        }
    }

};

1;

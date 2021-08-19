# dstx
Deathsticks 1.0
An iOS/android/web app to help people quit smoking.

## Goal
Help people quit smoking with the power of timestamps! My attempt at using technology to make things better. The idea is to gameify the process of quitting cigarettes, so that progress toward this goal feels rewarding for those who are stuck. Eventually use app components to build larger goal / activity tracking app.

### The Game:
A visualized algorithm to incentivize healthy activity with a point based reward system.

### Rules:
- A player in this game presses a button every time they smoke a cigarette.
- However many cigarettes are smoked that first day, this becomes the daily 'nadir' (N) of the player: the most amount of cigarettes they've smoked in a day, ever       (while playing the game).
- The next day, or the next time the player logs in and presses the button, the previous daily N is inherited by this new day.
- If a player's daily smoke count becomes greater than N, this new 'nadir' replaces that daily N value.
- Points are given as follows: 
    + Each day a player will receive a score, from 0 (worst) to 100 (best). 
    + If a player smokes 0 times in a day, their daily score is 100. 
    + When a player has smoked enough cigarettes to reach their daily N value (the most cigarettes they have smoked in a day while playing), their score is 0. Any          additional amout above N is also 0.

### Example: 
Lets say on the first day a player smokes 10 cigarettes. They get 0 points, since this is the most they've recorded while playing. On the second day, they smoke 15 times. They had a rough day. They again get 0 points. On the third day (or fourth or fifth), they smoke 9 times. In this case they get (1 - ( 9 / 15 )) * 100 points, or 40 points, since 15 is the most they've recorded while playing on that day. Finally, on the last day, they smoke 0 times. They get (1 - (0 / N_max)) * 100, or 100 points, where N_max is the most they've ever smoked in a day while playing the game. 
They have won the game, and they have a bunch of useless points but hey, they quit smoking. 🎉

### Formula: 
Y_d: daily score {0, 100} 
X: amount of cigarettes smoked by a player 
N_d: daily nadir value.

y_d = (1 - (- x / n_d)) * 100

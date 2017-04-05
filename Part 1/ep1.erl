-module(ep1).

-export([studCan/4, even/3, odd/1]).

studCan(Stdnt1, Stdnt2, Stdnt3, NumTurns) ->
  io:fwrite("Student 1: ~p, Student 2: ~p, Student 3: ~p, Turn: ~p~n", [Stdnt1, Stdnt2, Stdnt3, NumTurns]), % Display starting values
  REven = even(Stdnt1, Stdnt2, Stdnt3), % Ensure that students all have even number of candies
  if
    NumTurns == 0 ->
      io:fwrite("Done.~n"); % Once turns reaches 0, end
    REven == false ->
      io:fwrite("Only input even numbers.~n"); % Ensure user enters even numbers
    Stdnt1 == Stdnt2 andalso Stdnt2 == Stdnt3 -> % When all students have equal number of candies the game ends
      io:fwrite("Even Numbers All Around BRO!~n");
    true ->
          S1half = Stdnt1/2, % Students are giving half of their candy to their neighbor
          S2half = Stdnt2/2,
          S3half = Stdnt3/2,

          S1Updated = odd(trunc(Stdnt1/2 + S3half)), % Teacher adds 1 candy to a student if they have an odd number of candies
          S2Updated = odd(trunc(Stdnt2/2 + S1half)),
          S3Updated = odd(trunc(Stdnt3/2 + S2half)),

          NewTurns = NumTurns - 1, % Decreases the number of turns
          studCan(S1Updated, S2Updated, S3Updated, NewTurns) % Restart the process with one less turns
  end.

% Helper function to ensure the students have even number of candies
even(A, B,C)->
  if ((A band 1) == 0) and ((B band 1) == 0) and ((C band 1) == 0) ->
    true;
  true ->
    false
  end.

% Function simulating teacher giving a student with an odd number of candies
% a candy to be even.
odd(X) when X >= 0 ->
  if ((X rem 2) == 1) -> X + 1;
  true -> X
end.

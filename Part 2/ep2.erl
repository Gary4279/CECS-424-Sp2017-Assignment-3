-module(ep2).

-export([openFile/1, tupleList/2, words/1, wordCount/1]).

% Function to open a file
openFile(File) ->
  {ok, IoDevice} = file:open(File, read),
  L1 = io:get_line(IoDevice, ''),
  Words = string:tokens(L1, " \\,.()/<>=\"").

% Function that returns a list of tuples with words
tupleList(KeyWord, TList) ->
  WordExist = lists:keyfind(KeyWord, 1, TList), % Checks if key word exists in the list
  case WordExist of
    false ->
      lists:append(TList, [{KeyWord, 1}]); % If not, add to list with starting frequency 1
    _Else ->
      {_,B} = WordExist, % If so, Find tuple with key word
      Tuple = {KeyWord, B+1}, % Create a new tuple with frequency incremented by 1
      lists:keyreplace(KeyWord, 1, TList, Tuple) % replace old tuple with new tuple
   end.


% Function to return a hash table of words and their frequencies
words(WordList) ->
  lists:foldl(fun(X, Z) -> tupleList(string:to_lower(X), Z) end, [], WordList).


% Function to print out words and their frequencies
wordCount(File) ->
  Words = openFile(File), % Opens a file
  FinalWordCount = lists:keysort(2,words(Words)), % Sorts the words
  io:format("~p~n", [lists:reverse(FinalWordCount)]). % Prints out Words and their frequencies

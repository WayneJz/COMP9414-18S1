%Q1: negative square sum up

sumsq_neg([], 0).
%for base case,empty list

sumsq_neg([First | Rest], Sum) :-
	First < 0,
	sumsq_neg(Rest, X),
	Sum is First * First + X.
%if negative, square it and sum up

sumsq_neg([First | Rest], Sum) :-
	First >= 0,
        sumsq_neg(Rest, X),
        Sum is X.
%if not negative, do not sum up the square


%Q2: all like all function, adding likes is needed

like_all(_,[]).
%for sub-function base case, persons like no goods

like_all(P,[H|T]):-
%sub-function, consider if the person like all goods
	likes(P,H),
	like_all(P,T).

all_like_all([], _).

all_like_all(_ , []).
%for function base case, if either is empty list.

all_like_all([FirstPs | RestPs], [FirstGd | RestGd]):-
	like_all(FirstPs, [FirstGd | RestGd]),
	all_like_all(RestPs, [FirstGd | RestGd]).
%recursion to use sub-function, to check all persons


%Q3: square root

sqrt_table(X, Y, Result):-
	X >= Y,
	Y >= 0,
%base case, to avoid errors
%errors are sq root less than 0 and X less than Y

sqrt_table_Exitable(X, Y, [], Result).
%initiailize the counter, counter used to store the sum

sqrt_table_Exitable(X, Y, C, C):-
	X < Y.
%when X less than Y, exit
%when exit, counter C gives value to the result

sqrt_table_Exitable(X, Y, C, Result):-
	X >= Y,
	H is Y,
	T is sqrt(Y),
	Y1 is Y + 1,
	sqrt_table_Exitable(X, Y1, [[H | [T]] | C ] , Result).
%calculate square roots between X and Y
%recursion use to append list


%Q4: successive increasing

chop_up([],[]).
%base case, when empty list is given

chop_up([List],[List]).
%initialize two lists, for input and output

chop_up([FirstEl,SecondEl|Rest],[FirstEl|RestR]):-
	SecondEl=\=FirstEl+1,
	!,
	chop_up([SecondEl|Rest],RestR).
%consider if increasing sequence, pack up them into sub-list
%cut avoids excessive backtrack, no using will pack up all pairs

chop_up(List,[[FirstEl,SecondEl]|RestR]):-
	append([FirstEl|_],[SecondEl,ThirdEl|Rest],List),
	ThirdEl=\=SecondEl+1,
	!,
	chop_up([ThirdEl|Rest],RestR).
%if increasing sequence, delete interval elements, until not increasing
%third element detects the terminal point of sub-lists
%cut avoids excessive backtrack, no using will delete all intervals

chop_up([FirstEl|SecondEl],[[FirstEl,Rest]]):-
	append(_,[Rest],SecondEl).
%for no increasing sequence, append elements to answer list
%append directly, without using sublists


%Q5: tree eval

tree_eval(_Num, tree(empty,Letter_Z,empty), Eval) :-
    number(Letter_Z),
    Eval is Letter_Z.
%detect if z is a letter or a number, if number, gives value to eval

tree_eval(Num, tree(empty,Letter_Z,empty), Eval) :-
    Letter_Z = z,
    Eval is Num.
%if letter z, then number gives value to eval

tree_eval(Value, tree(tree(LeftL,LeftOp,LeftR),Op,tree(RightL,RightOp,RightR)), Eval) :-
    tree_eval(Value, tree(LeftL,LeftOp,LeftR), LeftEval),
    tree_eval(Value, tree(RightL,RightOp,RightR), RightEval),
    Calculator=..[Op,LeftEval,RightEval],
    Eval is Calculator.
%calculator is to calculate it with numbers and operators
%consider it contains non-numeric atoms, which are operators
%recursion from left-left to right-right binary tree

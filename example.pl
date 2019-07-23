% this is a scratch file for my prolog code


% example epistemic model
% first define set of agents and set of propositions

agents([a,b]).
propositions([p,q]).
print("this is printed").
    
% begin model

worlds(2).
% there are two worlds in this model


valuation(1,[p]).
valuation(2,[q]).
% world 1 satisfies p, world 2 satisfies q.

relations(a,[[1],[2]]).
% a has a minimal epistemic relation

relations(b,[[1,2]]).
% b has a maximal relation


% END OF THE EXAMPLE EPISTEMIC MODEL

% check whether X is a formula of the basic epistemic language

is_formula(X) :- propositions(Y), member(X,Y).                    %propositions
is_formula(X) :- X = [Y,Z], is_formula(Y), is_formula(Z).         %conjunction is of the form [Y,Z]
is_formula(X) :- X = ['n',Y], is_formula(Y).                      %negation is of the form [n,Z]
is_formula(X) :- X = [Y,Z], agents(A), member(Y,A), is_formula(Z).%possibility is of the form [i,Z], where i is in agents.

% checks that X,Y is a world, formula pair

world_formula(X,Y) :- worlds(Worlds), X =< Worlds, 1 =< X,  is_formula(Y).

% reachability predicate: X can see Z from Y

reachable(X,Y,Z) :- agents(A), member(X,A),  %X is an agent
		    worlds(W), 1 =< Y, 1 =< Z, Y =< W, Z =< W, %Y, Z are worlds
		    relations(X, P), member(P1,P), member(Y,P1), member(Z,P1).

% satisfaction predicate definedon world, formula pairs

satisfies(X,Y) :- world_formula(X,Y),      %X is a world, Y is a formula
		propositions(Z), member(Y,Z),                     %Y is a proposition
		valuation(X,P), member(Y,P).                      %Y is a member of X's valuation

satisfies(X,Y) :- world_formula(X,Y),
		  Y = [Z1,Z2], is_formula(Z1), is_formula(Z2),    %Y is a conjunction
		  satisfies(X,Z1), satisfies(X,Z2).               %X satisfies both.     

satisfies(X,Y) :- world_formula(X,Y),
		  Y = ['n',Z], is_formula(Z), not(satisfies(X,Z)).    %Y is a negation, X does not satisfy Z


satisfies(X,Y) :- world_formula(X,Y),
		  Y = [A1,Z], agents(A), member(A1,A), is_formula(Z), %Y is an A1 possibility modality, where A1 is an agent
		  relations(A1,P), member(P1,P), member(X,P1), member(X1,P1), satisfies(X1,Z).  

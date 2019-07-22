% this is a scratch file for my prolog code


% example epistemic model
% first define set of agents and set of propositions

agents([a,b]).
propositions([p,q]).
print("this is printed").
    
% begin model

worlds(2).
% there are two worlds in this model


p(1).
q(2).
% world 1 satisfies p, world 2 satisfies q.

a(1,1).
a(2,2).
% a has a minimal epistemic relation

b(1,1).
b(1,2).
b(2,1).
b(2,2).
% b has a maximal relation


% END OF THE EXAMPLE EPISTEMIC MODEL

is_formula(X) :- propositions(Y), member(X,Y).                    %propositions
is_formula(X) :- X = [Y,Z], is_formula(Y), is_formula(Z).         %conjunction
is_formula(X) :- X = ['n',Y], is_formula(Y).                      %negation
is_formula(X) :- X = [Y,Z], agents(A), member(Y,A), is_formula(Z).%knowledge

satisfies(X,Y) :- worlds(Y), X < Y, is_formula(Y),
    

%% FIND POLICY SIMPLE
%This function takes inputs from iteration file and returns optimal value
% and policy functions

function [policyopt valuefit policy policyint v X u1 ] = findpolicy_simple2(n,beta,r,k,g,c0,c1,A,rec,S,re,max_k,min_k,tol,maxit)

%% Define payoff space (returns to pumping choice)
Gamma =@(x) x + eom2(rec,re,0,irrig(A,max_k,min_k,x),S) %limit next period's water levels

X = linspace(min_k,max_k,n); % an evenly spaced grid over water levels

% pre-compute the return function on the entire grid of states and possible
% choice variables
R = NaN(n,n);

for i = 1:n % loop over the water states;
    x = X(i);
    for j = 1:n % loop over next period's water states;
        y = X(j);
        
        R(i,j) = -Inf; % set the default return to negative infinity      
        % check to see if next period's water choice is feasible
        if(y <= Gamma(x)&&y>= min_k && y<= max_k);
            % if so, set the appropriate return and corresponding policy 
        wp(i,j)= (((y-x) + eom2(rec,re,0,irrig(A,max_k,min_k,x),S)).*(irrig(A,max_k,min_k,x)*S) )./irrig(A,max_k,min_k,x) ;  % Policy corresponding to grid space
        pi(i,j)=u12(wp(i,j),r,k,g,c0,c1,A,rec,S,re,max_k,min_k,irrig(A,max_k,min_k,x),x); %profit from choice of policy
        end
    end
end









end
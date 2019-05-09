%Mech 105: Homework 11 (False Position Function)
%By: Oscar Swartz
%Due: March 3, 2019 (@11:00am)

%Before using falsePosition.m put function to be evaluated in terms of x, set equal to 0, using form 
%"(function name) = @(x) (expression in terms of x)"
%EX: function = @(x) x^4+5*x^2-5

function[root, fx, ea, iter] = falsePosition(func,x_L,x_U,es,maxiter)
format long
%func = name of function
%x_l = lower guess
%x_u = upper guess
%es = desired relative error (in percent)/(Default is 0.0001%)
%maxiter = number of desired inerations (Default is 200)
if nargin > 5%checking number of inputs
    msg = '"Too Many Inputs" - falsePosition only requires 3 inputs with 2 optional';
    error(msg)%throwing up error
end
if nargin < 3%checking number of inputs
    msg = '"Too Few Inputs" - falsePosition requires at least 3 inputs with 2 optional';
    error(msg)%throwing up error
end
if nargin == 3%checking number of inputs
    es = 0.0001;
    maxiter = 200;%placing defaults
end
if nargin == 4%checking number of inputs
    maxiter = 200;%placing defaults
end
if func(x_L) <= 0 && func(x_U) <= 0 || func(x_L) >= 0 && func(x_U) >= 0%checking that x_l and x_u are opposite signs
    msg = '"Incorrect Bracketing" - upper and lower bounds need to be on opposite sides of a single root.';
    error(msg)%throwing up error
end
if es <= 0 || es >= 100%checking for user input error of desired relative error
    msg = '"Incorrect Relative Error" - can not have a relative error less than 0% or more than 100%.';
    error(msg)%throwing up error
end
if maxiter < 2 || maxiter > 1000%checking for user input error of desired iterations
    msg = '"Incorrect Number of Iterations" - can not have fewer iterations than 2 or more than 1000.';
    error(msg)%throwing up error
end
fx_U = func(x_U);%function at upper bound
fx_L = func(x_L);%function at lower bound
ea = 100;%starting error
iter = 1;%starting iteration
while ea > es || iter > maxiter%while loop for error and interations, which ever comes first will be the stopping criteria
    root = x_U-((fx_U*(x_L-x_U))/(fx_L-fx_U));%calculating root of linear line between bounds
    fx_R = func(root);%calculating function of root
    if func(x_L) < 0 && func(x_U) > 0
        if fx_R < 0
            fx_L = fx_R;
            x_L = root;%switching lower bound with root
        elseif fx_R > 0
                fx_U = fx_R;
                x_U = root;%switching upper bound with root
        end
    end
    if func(x_L) > 0 && func(x_U) < 0
        if fx_R > 0
            fx_L = fx_R;
            x_L = root;%switching lower bound with root
        elseif fx_R < 0
                fx_U = fx_R;
                x_U = root;%switching upper bound with root
        end
    end
    root_2 = x_U-((fx_U*(x_L-x_U))/(fx_L-fx_U));%calculating new root
    ea = abs(((root_2-root)/root_2)*100);%calculating error between both calculated roots
    iter = iter + 1;%calculating iteration
    fx = func;%function used
end
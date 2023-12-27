clc
clear
close all

epsilon = input('Enter epsilon:\n');
%for example 0.0001
p = input('Enter [x0 y0]:\n');
%for example [4 4]
inputF = input('Enter the objective function:\n', 's');
stringF = strcat('@(x, y)(', inputF, ')');
f = str2func(stringF)

syms x y
v = [x, y];

grad_func = matlabFunction(gradient(f,v));
grad_value = grad_func(p(1) , p(2));
grad_norm = norm(grad_value);

hess_func = matlabFunction(hessian(f,v));
hess_value = hess_func(p(1) , p(2));

%for example @(x,y)(x*y-x^2)
%g=input('Enter the gradient of the objective function:\n');
%for example @(x,y)[y-2*x x]
%h=input('Enter the hessian of the objective function:\n');
%for example @(x,y)[2 1;1 0]
%grad=g(x(1),x(2));
%hess=h(x(1),x(2));

while grad_norm >= epsilon
    d = hess_value \ -grad_value;
    p = p + d.';
    disp(['Point: ' mat2str(p)])
    grad_value = grad_func(p(1) , p(2));
    grad_norm = norm(grad_value);
    hess_value = hess_func(p(1) , p(2));
end
disp([mat2str(p) ' is the optimal solution and the optimal value is ' num2str(f(p(1),p(2)))])
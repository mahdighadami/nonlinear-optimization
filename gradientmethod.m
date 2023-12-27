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

syms x y s
v = [x, y];
grad_func = matlabFunction(gradient(f,v));
grad_value = grad_func(p(1) , p(2));
grad_norm = norm(grad_value);

%for example @(x,y)(x^2+x*y)
%g=input('Enter the gradient of the objective function:\n');
%for example @(x,y)[2*x+y x]
%grad=g(x(1),x(2));


while grad_norm >= epsilon
    h = @(s)f(p(1)-s*grad_value(1), p(2)-s*grad_value(2));
    optimS = fminbnd(h,0,10);
    optimS = str2num(num2str(optimS));
    p = p - (optimS*grad_value).';
    grad_value = grad_func(p(1) , p(2));
    grad_norm = norm(grad_value);
    disp(['Optimal line search coefficient: ' num2str(optimS)])
    disp(['Point: ' mat2str(p)])
    disp(['Gradient value: ' mat2str(grad_value)])
    disp(['Gradient norm: ' num2str(optimS) '\n'])
end
disp([mat2str(p) ' is the optimal solution and the optimal value is ' num2str(f(p(1),p(2)))])
%fsurf(f)
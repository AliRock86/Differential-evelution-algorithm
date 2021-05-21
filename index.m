l = [1 1 4 5];
u = [2 2 6 8];
G_max = 100;
Dp = 4;
Np = 10 * Dp;
CR = 0.5;
F = 0.4;
S = zeros(Dp,Np);
S_M = zeros(Dp,Np);
S_CR = zeros(Dp,Np);
Fp = zeros(1,Np);
Fc = zeros(1,Np);

while( G_max > 100 )

% INIT
for i=1:Np;
for j=1:Dp;
S(j,i) = l(1,j)+rand()*(u(1,j)-l(1,j));
end
Fp(1,i) = S(1,i)^3 + 3*S(2,i)^2 - 12*S(3,i)^2 - 4*S(4,i)+10;
end

% generate MUTATION
for i=1:Np;
a = floor(rand * Np) + 1 ; 
while a == i
a = floor(rand * Np) + 1 ; 
end
b = floor(rand * Np) + 1 ; 
while b == i || b == a
b = floor(rand * Np) + 1 ; 
end
c = floor(rand * Np) + 1 ; 
while c == i || c == a || c == b
c = floor(rand * Np) + 1 ; 
end
for j=1:Dp;
S_M(j,i) = S(j,a) + F * (S(j,b) - S(j,c));
end
end

% generate CROSSOVER
for i=1:Np;
for j=1:Dp;
I = randi([1 4]);
if rand() <= CR || j == I
S_CR(j,i) = S_M(j,i);
else
S_CR(j,i) = S(j,i);
end
Fc(1,i) = S_CR(1,i)^3 + 3*S_CR(2,i)^2 - 12*S_CR(3,i)^2 - 4*S_CR(4,i)+10;
end
end


% generate SELECTION
for i=1:Np;
for j=1:Dp;
if Fc(1,i) < Fp(1,i)
S(j,i) = S_CR(j,i);
else
S(j,i) = S(j,i);
end
end
end

G_max = G_max + 1;
end
S


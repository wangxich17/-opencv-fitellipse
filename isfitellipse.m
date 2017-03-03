function flag = isfitellipse(X,Y)
% FITELLIPSE Least-squares fit of ellipse to 2D points.
% A = FITELLIPSE(X,Y) returns the parameters of the best-fit
% ellipse to 2D points (X,Y).
% The returned vector A contains the center, radii, and orientation
% of the ellipse, stored as (Cx, Cy, Rx, Ry, theta_radians)
%
% Example: Run fitellipse without any arguments to get a demo
if nargin == 0
% Create an ellipse
t = linspace(0,2);
Rx = 300
Ry = 200
Cx = 250
Cy = 150
Rotation = .4 % Radians
x = Rx * cos(t);
y = Ry * sin(t);
nx = x*cos(Rotation)-y*sin(Rotation) + Cx;
ny = x*sin(Rotation)+y*cos(Rotation) + Cy;
% Draw it
plot(nx,ny,'o');
% Fit it
fitellipse(nx,ny)
% Note it returns (Rotation - pi/2) and swapped radii, this is fine.
return
end
% normalize data
mx = mean(X);
my = mean(Y);
sx = (max(X)-min(X))/2;
sy = (max(Y)-min(Y))/2;
x = (X-mx)/sx;
y = (Y-my)/sy;
% Force to column vectors
x = x(:);
y = y(:);
% Build design matrix
D = [ x.*x x.*y y.*y x y ones(size(x)) ];
% Build scatter matrix
S = D'*D;
[len_a,len_b]=size(S);
flag=1;
for i=1:len_a
    for j=1:len_b
        if(isnan(S(i,j))|| isinf(S(i,j)))
            flag=0;
        end
    end
end

end
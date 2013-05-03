function [dydt,jac]=network28(x,a,b,c)

dydt=[(a(1)*x(1)^4)/(x(1)^4 + 1/16) - x(1) + (b(1)*x(2)^4)/(x(2)^4 + 1/16) + (c(1)*x(3)^4)/(x(3)^4 + 1/16);a(2)/(16*(x(1)^4 + 1/16)) - x(2) + (b(2)*x(2)^4)/(x(2)^4 + 1/16) + (c(2)*x(3)^4)/(x(3)^4 + 1/16);a(3)/(16*(x(1)^4 + 1/16)) - x(3) + b(3)/(16*(x(2)^4 + 1/16)) + c(3)/(16*(x(3)^4 + 1/16))];
jac=[[(4*a(1)*x(1)^3)/(x(1)^4 + 1/16) - (4*a(1)*x(1)^7)/(x(1)^4 + 1/16)^2 - 1, (4*b(1)*x(2)^3)/(x(2)^4 + 1/16) - (4*b(1)*x(2)^7)/(x(2)^4 + 1/16)^2, (4*c(1)*x(3)^3)/(x(3)^4 + 1/16) - (4*c(1)*x(3)^7)/(x(3)^4 + 1/16)^2]; [-(a(2)*x(1)^3)/(4*(x(1)^4 + 1/16)^2), (4*b(2)*x(2)^3)/(x(2)^4 + 1/16) - (4*b(2)*x(2)^7)/(x(2)^4 + 1/16)^2 - 1, (4*c(2)*x(3)^3)/(x(3)^4 + 1/16) - (4*c(2)*x(3)^7)/(x(3)^4 + 1/16)^2]; [-(a(3)*x(1)^3)/(4*(x(1)^4 + 1/16)^2), -(b(3)*x(2)^3)/(4*(x(2)^4 + 1/16)^2), - (c(3)*x(3)^3)/(4*(x(3)^4 + 1/16)^2) - 1]];

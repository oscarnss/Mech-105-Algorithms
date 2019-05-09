function[L,U,P] = luFactor(A)
% LU Factorization / By : Oscar Swartz
% ------------------------------------------------------------------------
% This function finds the lower triangular matrix, the upper triangular
% matix, and the pivot matrix of a square matrix given by the user.
% ------------------------------------------------------------------------
% Making sure user put in a square array
[m,n] = size(A);
if m ~= n
    error('A square matrix must be used')
end
% ------------------------------------------------------------------------
% Setting up initial variables and matrices
P = eye(size(A));
L = P;
U = A;
% ------------------------------------------------------------------------
% Pivoting
for r = 1:n
    [p_e,p_p] = max(abs(U(r:n,r)));
    p_p = p_p+(r-1);
    if p_p ~= r
         U([p_p r],:) = U([r p_p],:);% Pivoting A
         P([p_p r],:) = P([r p_p],:);% Pivoting P
         if r >= 2
             x = L(r,1:r-1);
             L(r,1:r-1) = L(p_p,1:r-1);
             L(p_p,1:r-1) = x; % Pivoting L
         end
    end
% ------------------------------------------------------------------------
% Elimination
    for y = r+1:n
        L(y,r) = U(y,r)/U(r,r);% Calculating elimination multi factor
        U(y,:) = U(y,:)-L(y,r)*U(r,:); % Multiplying and subtracting
    end
end

        

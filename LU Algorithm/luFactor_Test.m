luFactor([1 2 3; 4 5 6; 7 8 9])
function[L,U,P] = luFactor(A)
% LU Factorization / By : Oscar Swartz
% ------------------------------------------------------------------------
% This function finds the lower triangular matrix, the upper triangular
% matix, and the pivot matrix of a square matrix given by the user.
% ------------------------------------------------------------------------
% Making sure user put in a square array
[m,n] = size(A);
if m == n
    % Setting up initial variables and matrices
    U = A;% A becomes U
    P = eye(size(A));% Finding the initial pivot matrix
    L = P;% Initial L
    c = 1;% Column number being eliminated
    r = 1;% Row number being eliminated
    r2 = r+1;% Row below initial
    % ------------------------------------------------------------------------
    while sum(sum(tril(U,-1))) ~= 0
        X = tril(U,-1); % Current lower triangular matrix of U
        while sum(X(:,c)) ~= 0
            if r+1 <= m
            % Finding the pivot element and its position
            p_c = A(:,c);% Extracting the column used to pivot from the matrix
            p_e = max(p_c);% Finding the pivot element using >>max
            p_p = find(p_c==p_e);% Finding the postion of the pivot element
            % ----------------------------------------------------------------
            % Pivot
            if p_p ~= r % If the pivot element isn't already in the correct row
                U([p_p r],:) = U([r p_p],:);% Pivoting A
                P([p_p r],:) = P([r p_p],:);% Pivoting P
            end
            % ----------------------------------------------------------------
            % Finding the elimination factor
            ef_b = U(r,c); % Finding the bottom of the fraction
            ef_t = U(r2,c); % Finding the top of the fraction
            ef = ef_t/ef_b; % finding the fraction
            % ----------------------------------------------------------------
            % Elimination
            er = ef*U(r,:); % Multiplying by the elimination factor
            nr = U(r2,:)-er; % Subtration
            % ----------------------------------------------------------------
            % Replacing the original row in U with the claculated one
            U(r2,:) = nr; % Replacing row
            % ----------------------------------------------------------------
            % Book Keeping
            r = r+1; % Beginning to work on the next row
            % ----------------------------------------------------------------
            end
        end
        % --------------------------------------------------------------------
        % Book Keeping
        c = c+1; % Beginning to work on the next column
        % --------------------------------------------------------------------
    end
else
    error('A square matrix must be used')
end
disp(U)
disp(P)
end

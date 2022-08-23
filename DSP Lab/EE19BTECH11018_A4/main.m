clc;close all;
n = 50;
iter = 50;

% Arrays for storing the time taken for each iteration
block_time = zeros(iter,1);
cholesky_time = zeros(iter,1);
gauss_jordan_time = zeros(iter,1);

bb = zeros(iter,1);
bc = zeros(iter,1);
bj = zeros(iter,1);

% Running a simulation for some iterations to get average time
for i = 1:iter
    % Taking a random matrix as input
    M = randn(n,n);
    M = M*M';
    M_inv = inv(M);
    
    % Running Block Inversion 
    %tic and toc is used to check the time taken
    tic = cputime;
    I = block_inv(M);
    toc = cputime;
    bb(i) = norm(M_inv - I);
    block_time(i) = toc-tic;
    
    % Running Cholesky decomposition Inverse
    tic = cputime;
    I = cholesky_inv(M);
    toc = cputime;
    bc(i) = norm(M_inv - I);
    cholesky_time(i)= toc-tic;
    
    % Running Gauss Jordan Method
    tic = cputime;
    I = gauss_jordan(M);
    toc = cputime;
    bj(i) = norm(M_inv - I);
    gauss_jordan_time(i)= toc-tic;

end


fprintf("Average time taken for cholesky decomposition inversion = %f\n",sum(block_time)/iter)
fprintf("time taken for block inversion = %f\n",sum(cholesky_time)/iter)
fprintf("time taken for gauss jordan inversion = %f\n",sum(gauss_jordan_time)/iter)

hold on;
plot(block_time)
plot(cholesky_time)
plot(gauss_jordan_time)
legend(["Time taken by Blockwise Inverse","Time taken by Cholesky decomposition Inverse","Time taken by Gauss Jordan Method"])
xlabel("Iterations")
ylabel("Time Taken")

% Block inversion 
 function I = block_inv(M)
    n = size(M,1);
    x = ceil(n/2); %Taking the block size as n/2
    
    %Since we use recursion when n=1 we break it
    if(n==1)    
        I = 1/M;
    else
        % Dividing the input matrix into 
        A = M(1:x,1:x);
        B = M(1:x,x+1:n);
        C = M(x+1:n,1:x);
        D = M(x+1:n,x+1:n);
        
        %Recursive calls for finding inverse of A and schur component
        %inverse
        A_inv = block_inv(A);   
        schur_Inv = block_inv(D - C*A_inv*B);
        
        %As discussed in the report we use the formulas proved to find the
        %blocks of inverse array
        W = A_inv+A_inv*B*schur_Inv*C*A_inv;
        X = -1*A_inv*B*schur_Inv;
        Y = -1*schur_Inv*C*A_inv;
        Z = schur_Inv;
        I = [W X;Y Z];
    end
 end
 
 %Cholesky decomposition, return the lower triangular matrix
 function L = cholesky_decomposition(M)
    n = size(M,1);
    L = zeros(n,n);
    for i = 1:n
       for j = 1:i
          sum = 0;
          for k = 1:j-1
             sum = sum + L(i,k)* L(j,k);
          end
          if(i == j)
              L(i,j) = sqrt(M(i,j) - sum);
          else
              L(i,j) = 1.0 / L(j,j) * (M(i,j) - sum);
          end
       end
    end
 end
 
 % Forward substitution method for finding inverse of triangular function
 function Linv = triangular_matrix_inv(L)
    n = size(L,1);
    Linv = zeros(n,n);
    for l = 1:n
        b = zeros(n, 1);
        b(l) = 1;
        Linv(1,l) = b(1)/L(l,1);
        for i = 2:n
            sum = 0;
            for j = 1:i-1
                sum = sum + L(i,j)*Linv(j,l);
            end
              Linv(i,l) = (b(i)-sum)/L(i,i);
        end
    end
 end
 
 % Cholesky Decomposition Inverse 
 function I = cholesky_inv(M)
    L = cholesky_decomposition(M);  %The cholesky decomposition lower triangular matrix
    Linv = triangular_matrix_inv(L);%Inverse of the lower triangular matrix
    I = Linv'*Linv;
 end
 
 % Gauss jordan Method
 function I = gauss_jordan(M)
    n = size(M,1);
    M = [M eye(n)]; %Augmented Matrix
    
    %Applying the row operations
    for j = 1:n
        M(j,:) = M(j,:)./ M(j,j);
        for i = 1:n
            if(i~=j)
                M(i,:) = M(i,:) - M(i,j).*M(j,:);
            end
        end
    end
    
    % Inverse matrix is the second half block
    I = M(:,n+1:end);
 end
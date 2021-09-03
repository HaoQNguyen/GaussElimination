using LinearAlgebra
using DelimitedFiles

function checkDiagonal(A)

    (len, wid) = size(A);

    for i = 1:len

        sum = 0;

        for j = 1:wid

            i == j ? continue : sum = sum + abs(A[i,j]);

        end

        if abs(A[i,i]) < sum

            return "not diagonally dominant";

        end

    end

    return "diagonally dominant";
    
end

function diagonalize(A, b)
    
    (row, col) = size(A);

    for R = 1:(row-1)

        for r = (R+1):row

            ratio = A[r,R] / A[R,R];

            for c = 1:col

                A[r,c] = A[r,c] - ratio * A[R,c];
                
            end

            b[r,1] = b[r,1] - ratio * b[R,1];

        end

    end

end

function backSubstitute(A,b)

    (row, col) = size(A);
    x = zeros(row, 1);

    x[end, 1] = b[end, 1] / A[end,end];

    for r = (row-1):-1:1

        sum = 0;

        for c = col:-1:(r+1)

            sum = sum + A[r,c] * x[c,1];

        end

        x[r,1] = ( b[r,1] - sum ) / A[r,r];

    end

    return x;
    
end

A = readdlm("A-2.txt");
b = readdlm("b-1.txt");

println("A is ", checkDiagonal(A));

diagonalize(A, b);
x = backSubstitute(A, b);

for i in x
    println(i);
end
# Functions for changing the values of an associative array

#=
Reduce all value to logical, checking if that cell is empty
=#

using SparseArrays,LinearAlgebra

logical(A::Assoc) = Assoc(copy(A.row),copy(A.col),promote([1.0],A.val)[1],LinearAlgebra.fillstored!(dropzeros!(copy(A.A)),1))

function str2num(A::Assoc)
    r,c,v = find(A)
    v = Meta.parse.(v) # this won't work for string values- find numeric strings first, convert all others to 1
    A = Assoc(r,c,v)
end

# TODO: Write num2str

########################################################
# D4M: Dynamic Distributed Dimensional Data Model
# Architect: Dr. Jeremy Kepner (kepner@ll.mit.edu)
# Software Engineer: Alexander Chen (alexc89@mit.edu)
########################################################

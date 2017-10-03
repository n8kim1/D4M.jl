import Base.(==)
#=
== : get a new Assoc where all of the elements of input Assoc matches the given Element.
=#
(==)(A::Assoc,E::Union{AbstractString,Number}) = equal(A::Assoc,E::Union{AbstractString,Number})
function equal(A::Assoc, E::Union{AbstractString,Number})
    tarIndex = searchsortedfirst(A.val,E)
    if (isa(E,Number) & (size(Val(A),1)==1) & (Val(A)[1] == 1.0)  ) 
        tarIndex = E
    end
    rowkey, colkey, valkey = findnz(A.A)
    mapping = find( x-> x == tarIndex, valkey)
#    rowkey , colkey = unique(rowkey[mapping]), unique(colkey[mapping])
#    sort!(rowkey)
#    sort!(colkey)
    return A[rowkey[mapping],colkey[mapping]]
end

==(E::Union{AbstractString,Number},A::Assoc) = (A == E)

########################################################
# D4M: Dynamic Distributed Dimensional Data Model
# Architect: Dr. Jeremy Kepner (kepner@ll.mit.edu)
# Software Engineer: Alexander Chen (alexc89@mit.edu)
########################################################


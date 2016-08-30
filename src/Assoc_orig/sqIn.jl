#=

 sqIn : 
=#
#TODO documentation
function sqIn(A::Assoc)
    AtA = deepcopy(A)
    if !isempty(A)
        AtA = logical(A)
    end

    AA = Adj(AtA)
    AAtAA = AA' * AA;

    AtA.A = AAtAA;
    AtA.row = AtA.col
    return AtA
end

########################################################
# D4M: Dynamic Distributed Dimensional Data Model
# Architect: Dr. Jeremy Kepner (kepner@ll.mit.edu)
# Software Engineer: Alexander Chen (alexc89@mit.edu)
########################################################


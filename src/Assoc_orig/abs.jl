function abs(A:Assoc)
    #abs: Absolutee value of an inputted numerical associative array.

    if isempty(A.val)
        error("Using non numerical associative array for abs is not recommended.")
    end

    AT = deepcopy(A)
    AT.A = abs(AT.A)
    return AT
end

########################################################
# D4M: Dynamic Distributed Dimensional Data Model
# Architect: Dr. Jeremy Kepner (kepner@ll.mit.edu)
# Software Engineer: Alexander Chen (alexc89@mit.edu)
########################################################


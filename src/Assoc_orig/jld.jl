using SparseArrays#, LinearAlgebra
import JLD: writeas,readas

#=
Assoc Serialized for saving
Note that saving would convert row and col types to number.
=#

# Delimiter for saving- using new line is safer than comma!
del = "\n"

struct AssocSerial
    rowstr::AbstractString
    colstr::AbstractString
    valstr::AbstractString

    rownum::AbstractString
    colnum::AbstractString
    valnum::AbstractString
    
    A::SparseMatrixCSC
end

function writeas(data::Assoc)
    #Get parts from the assoc
    row = getrow(data)
    col = getcol(data)
    val = getval(data)
    A   = dropzeros!(getadj(data))

    #Split the mapping array into string and number arrays for storage
    rowindex = searchsortedfirst(row,AbstractString,lt=isa)
    colindex = searchsortedfirst(col,AbstractString,lt=isa)
    valindex = searchsortedfirst(val,AbstractString,lt=isa)
    #test if there are string elements in the array
    if (rowindex == 1)
        rowstr = ""
    else
        rowstr = join(row[1:(rowindex-1)],del)*del;#chunkstring(join(row[1:(rowindex-1)],del)*del,maxchar)
    end

    if (colindex == 1)
        colstr = ""
    else
        colstr = join(col[1:(colindex-1)],del)*del;#chunkstring(join(col[1:(colindex-1)],del)*del,maxchar)
    end
    
    if (valindex == 1)
        valstr = ""
    else
        valstr = join(val[1:(valindex-1)],del)*del;#chunkstring(join(val[1:(valindex-1)],del)*del,maxchar)
    end
    
    #test if there are number elements in the array.  Note that by serialization all numbers will be converted to float.

    if (rowindex == size(row,1)+1)
        rownum = ""
    else
        rownum = join(row[rowindex:end],del)#chunkstring(join(row[rowindex:end],del)*del,maxchar)
    end

    if (colindex == size(col,1)+1)
        colnum = ""
    else
        colnum = join(col[colindex:end],del)#chunkstring(join(col[colindex:end],del)*del,maxchar)
    end
    
    if (valindex == size(val,1)+1)
        valnum = ""
    else
        valnum = join(val[valindex:end],del)#chunkstring(join(val[valindex:end],del)*del,maxchar)
    end


    #Reconstitute converted parts into Serialized

    return AssocSerial(rowstr,colstr,valstr,rownum,colnum,valnum,A)
end

function readas(serData::AssocSerial)
    row = []
    # Last character is delimiter- in case saved with different delimiter
    if !isempty(serData.rowstr)
       row = vcat(row, split(serData.rowstr[1:end-1],serData.rowstr[end]))#vcat(row, split(join(serData.rowstr,"")[1:end-1],serData.rowstr[end][end]))
    end
    if !isempty(serData.rownum)
        row = vcat(row, map(float,split(serData.rownum,del)))#vcat(row, map(float,split(join(serData.rownum,"")[1:end-1],serData.rownum[end][end])))
    end
    row = Array{Union{AbstractString,Number}}(row)

    col = []
    if !isempty(serData.colstr)
       col = vcat(col, split(serData.colstr[1:end-1],serData.colstr[end]))#vcat(col, split(join(serData.colstr,"")[1:end-1],serData.colstr[end][end]))
    end
    if !isempty(serData.colnum)
        col = vcat(col, map(float,split(serData.colnum,del)))#vcat(col, map(float,split(join(serData.colnum,"")[1:end-1],serData.colnum[end][end])))
    end
    col = Array{Union{AbstractString,Number}}(col)
    
    val = []
    if !isempty(serData.valstr)
       val = vcat(val, split(serData.valstr[1:end-1],serData.valstr[end]))#vcat(val, split(join(serData.valstr,"")[1:end-1],serData.valstr[end][end]))
    end
    if !isempty(serData.valnum)
        val = vcat(val, map(float,split(serData.valnum,del)))#vcat(val, map(float,split(join(serData.valnum,"")[1:end-1],serData.valnum[end][end])))
    end
    val = Array{Union{AbstractString,Number}}(val)
    
    return Assoc(row,col,val,serData.A)
end

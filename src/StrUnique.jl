function StrUnique(inputString::AbstractString, csv= false)
    #TODO backwardMapping from unique string to index is not implemented, because there doesn't seem to be a application for such an array
    #Note: The unique output is sorted.
    separator = inputString[end]
    if(csv == true)
        separator = ','
    end
    strA = split(inputString,separator)
    if str[end] == separator
        strA = strA[1:end-1]
    end

    uniqueSeq = unique(strA)
    sort!(uniqueSeq)


    forwardMapping = [searchsortedfirst(uniqueSeq,x) for x in strA]

    backwardMapping = zeros(1,length(forwardMapping))

    return uniqueSeq,backwardMapping,forwardMapping
end

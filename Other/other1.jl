#Longest Increasing Subsequence
#The task is to find the length of the longest
#subsequence in a given array of integers such 
#that all elements of the subsequence are sorted 
#in strictly ascending order.

function LIS(L)
    if L == []
        return 0
    end
    N = [1] #representative list
    g = 1
    j = 2
    while j <= length(L)
        m = 0
        while m != -1
            println(m)
            if L[N[g-m]] < L[j]
                if m == 0
                    push!(N,j)
                    g = g + 1
                elseif L[N[g+1-m]] >= L[j]
                    N[g+1-m] = j
                end
                m = -2
                j = j + 1
            end
            m = m + 1
            if m == g
                if L[j] < L[N[1]]
                    N[1] = j
                end
                j = j + 1
                m = -1
            end
        end
    end

    return length(N)
end

#A faster code than above. May be O(nlogn)
function LISnlogn(L)
    if L == []
        return 0
    end
    N = [1] #representative list
    Lb = 1
    Ub = 1
    c = 1
    j = 2
    while j <= length(L)
        if L[N[1]] > L[j]
            N[1] = j
            Ub = length(N)
            Lb = 1
            j = j + 1
            continue
        end
        if L[N[end]] < L[j]
            push!(N,j)
            Ub = length(N)
            Lb = 1
            j = j + 1
            continue
        end
        while Ub-Lb > 1
            if L[N[c]] < L[j]
                Lb = c
            else
                Ub = c
            end
            c = (Ub + Lb) >>> 1
        end
        N[Ub] = j
        Ub = length(N)
        Lb = 1
        j = j + 1
    end

    return length(N)
end


println(LISnlogn([15,27,14,38,26,55,46,65,85]))

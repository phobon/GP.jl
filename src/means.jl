#Mean functions
export ZeroMean, LinearMean, LinearDiffMean

abstract MeanFunc

#------------------
#Constant zero mean
#------------------
immutable ZeroMean <: MeanFunc end
(::ZeroMean)(x) = 0.0

#-----------
#Linear mean
#-----------

#Proportional to each parameter's absolute value
type LinearMean <: MeanFunc
    k::Vector{Float64}
end
(m::LinearMean)(x) = dot(m.k, x)

#----------------------
#Linear difference mean
#----------------------

#Mean function outputs proportional to the parameter at scl_idx and the vector
#norm of the difference between the parameters at msr_idx and ref_idx.
type LinearDiffMean <: MeanFunc
    k::Float64
    scl_idx::Int
    msr_idx::Vector{Int}
    ref_idx::Vector{Int}
end

function (m::LinearDiffMean)(x)
    return m.k * x[m.scl_idx] * norm(x[m.msr_idx] - x[m.ref_idx])
end
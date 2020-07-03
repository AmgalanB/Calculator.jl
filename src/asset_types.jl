# Abstract type hierarchy
abstract type Asset end

abstract type Property <: Asset end
abstract type Investment <: Asset end
abstract type Cash <: Asset end

abstract type House <: Property end
abstract type Apartment <: Property end

abstract type FixedIncome <: Investment end
abstract type Equity <: Investment end

subtypes(Asset)
subtypes(Equity)

function subtypetree(roottype, level = 1, indent = 4)
    level == 1 && println(roottype)
    for s in subtypes(roottype)
        println(join(fill(" ", level * indent)) * string(s))
        subtypetree(s, level + 1, indent)
    end
end

subtypetree(Asset)

# simple functions on abstract types
describe(a::Asset) = "Something valuable"
describe(e::Investment) = "Financial investment"
describe(e::Property) = "Physical property"

# function that just raise an error
"""
    location(p::Property)

Returns the location of the property as a tuple of (latitude, longitude).
"""
location(p::Property) = error("Location is not defined in the concrete type")

# an empty function
"""
    location(p::Property)

Returns the location of the property as a tuple of (latitude, longitude).
"""
function location(p::Property) end

# interaction function that works at the abstract type level
function walking_disance(p1::Property, p2::Property)
    loc1 = location(p1)
    loc2 = location(p2)
    return abs(loc1.x - loc2.x) + abs(loc1.y - loc2.y)
end

a = Property
b = Property
walking_disance(a, b)

# Define immutable/composite types
struct Stock <: Equity
    symbol::String
    name::String
end

# instatitate a composite type
stock = Stock("AAPL", "Apple, Inc.")

# implementing the contract from abstract type
function describe(s::Stock)
    return s.symbol * "(" * s.name * ")"
end

# It's immutable!
#= REPL
julia> stock.name = "Apple LLC"
ERROR: setfield! immutable struct of type Stock cannot be changed
=#

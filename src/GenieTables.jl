module GenieTables

using SearchLight

export AbstractColumn, AbstractTable



abstract type AbstractColumn end

function render(column::AbstractColumn, object::AbstractModel) end

function header(column::AbstractColumn) end




struct DeleteColumn <: AbstractColumn
    template = "<td>Delete button!</td>"
end


struct EditColumn <: AbstractColumn end

struct FieldColumn <: AbstractColumn
    field::Symbol
end

struct LinkColumn <: AbstractColumn end

function render(col::DeleteColumn, object::T) where T <: AbstractModel
    "<td>Delete button!</td>"
end
    
function render(col::EditColumn, object::T) where T <: AbstractModel
    "<td>Edit button!</td>"
end

function render(col::FieldColumn, object::T) where T <: AbstractModel)





abstract type AbstractTable end







struct AdminTable{T} <: AbstractTable where T 
    objects::T
    columns::Vector{<:AbstractColumn}
end


function install(dest::String; force = false) :: Nothing
    src = abspath(normpath(joinpath(@__DIR__, "..", Genie.Plugins.FILES_FOLDER)))
    
    for f in readdir(src)
        isfile(f) && continue
        isdir(f) || mkpath(joinpath(src, f))
        
        Genie.Plugins.install(joinpath(src, f), dest, force = force)
    end
    
    nothing
end



end

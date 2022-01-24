module GenieTables

using Genie, SearchLight

export AbstractColumn, AbstractTable, render, header
export Column, FieldColumn, LinkColumn

################################################################################
####    Abstract Column                                                     ####
################################################################################
abstract type AbstractColumn end

function render(column::AbstractColumn, object::AbstractModel) end
function header(column::AbstractColumn) end

################################################################################
####    Column                                                              ####
################################################################################
struct Column <: AbstractColumn
    header::String
    template::String
end

function header(column::Column)
    column.header
end

function render(column::Column, object::T) where T <: AbstractModel
    partial(joinpath(Genie.config.path_resources, "tables", "views", column.template); object = object)
end

################################################################################
####    Field column                                                        ####
################################################################################
struct FieldColumn <: AbstractColumn
    header::String
    template::String
    accessor::Symbol
end

function render(column::FieldColumn, object::T) where T <: AbstractModel
    partial(joinpath(Genie.config.path_resources, "tables", "views", column.template);
            object = object, accessor = accessor)
end

################################################################################
####    Link column                                                         ####
################################################################################
struct LinkColumn <: AbstractColumn
    header::String
    template::String
    accessor::Symbol
    view_name::Symbol
end

function render(col::LinkColumn, object::T) where T <: AbstractModel
    partial(joinpath(Genie.config.path_resources, "tables", "views", column.template);
            object = object, accessor = accessor, view_name = view_name)
end



################################################################################
####    Tables
################################################################################
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

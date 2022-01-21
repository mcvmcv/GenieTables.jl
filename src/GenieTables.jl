module GenieTables


export AbstractColumn, AbstractTable



abstract type AbstractColumn end

function render_header(column::AbstractColumn, object::AbstractModel) end

function render_row(column::AbstractColumn, object::AbstractModel) end




struct DeleteColumn <: AbstractColumn
    header_template = ""
    row_template = ""
end







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

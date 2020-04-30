module FileRules

using FilePathsBase: Path, hasparent, iswritable

export Touch, Write

struct Touch{T}
    path::T
    filemode::Integer
    dirmode::Unsigned
end
Touch(path; filemode = 0o777, dirmode = 0o777) = Touch(path, filemode, dirmode)
function (t::Touch)()
    p = expanduser(t.path) |> Path
    if hasparent(p)
        mkpath(joinpath(splitpath(p)[1:end-1]...); mode = t.dirmode)
    end
    return chmod(touch(p), t.filemode)
end

struct Write{T}
    path::T
    mode::AbstractString
    function Write{T}(path, mode) where {T}
        @assert string(lowercase(mode)) ∈ ("r", "w", "a", "r+", "w+", "a+")
        return new(path, lowercase(mode))
    end
end
Write(path::T, mode) where {T} = Write{T}(path, mode)
function (w::Write)(x)
    p = expanduser(w.path) |> Path
    if !isfile(p)
        Touch(p)()
    end
    if !iswritable(p)
        error("file $p is not writable!")
    end
    if w.mode ∈ ("w", "w+")
        @info "try to overwrite file $p, a backup file will be created!"
        Touch(p * ".bkp")()
    end
    open(p, w.mode) do io
        write(io, x)
    end
end

end

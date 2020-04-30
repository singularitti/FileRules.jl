module FileRules

using FilePathsBase: Path, hasparent

export Touch

struct Touch
    path
    filemode::Integer
    dirmode::Unsigned
end
Touch(path) = Touch(path, 0o777, 0o777)
function (t::Touch)()
    p = expanduser(t.path) |> Path
    if hasparent(p)
        mkpath(joinpath(splitpath(p)[1:end-1]...); mode = t.dirmode)
    end
    return chmod(touch(p), t.filemode)
end

end

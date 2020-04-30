module FileRules

using FilePathsBase: Path, hasparent

export Touch

struct Touch
    path
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

end

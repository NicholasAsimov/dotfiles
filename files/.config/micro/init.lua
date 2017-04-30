function gorun()
    local buf = CurView().Buf -- The current buffer
    if buf:FileType() == "go" then
        HandleShellCommand("go run " .. buf.Path, true, true) -- the first true means don't run it in the background
    end
end
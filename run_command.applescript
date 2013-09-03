on execInNewTab(_title, _command)
  tell application "iTerm"
    activate
    tell the first terminal
      launch session "Default Session"
      tell the last session
        set name to _title
        write text _command
      end tell
    end tell
  end
end execInTerminalTab

on execInTerminalTab(_command, _terminal, _session)
  tell application "iTerm"
    activate
    set current terminal to _terminal
    tell _session
      select _session
      write text "clear"
      write text _command
    end tell
  end
end execInTerminalTab

on run argv
  set _command to item 1 of argv
  set _foundTab to false
  set _expected_title to (item 2 of argv)

  if length of argv is 2
    tell application "iTerm"
      repeat with t in terminals
        tell t
          repeat with s in sessions
            set _title to (name of s)

            if _title contains _expected_title then
              set _foundTab to true
              set _terminal to t
              set _session to s
              exit repeat
            end if
          end repeat
        end tell

        if _foundTab then
          exit repeat
        end if
      end repeat
    end tell

    if _foundTab then
      execInTerminalTab(_command, _terminal, _session)
    else
      execInNewTab(_expected_title, _command)
    end if
  end if
end run
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color brblue)
    set -l vcs_color (set_color brblue)
    set -l separator_color (set_color brblack)
    set -l prompt_status ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l prefix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set prefix 'root❯'
    end

    # Color the prompt and separator line red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color $last_status ' ' $normal

        set separator_color (set_color brred)
    end

    #########################################################################
    ### PROMPT PRINTING
    #########################################################################

    ### print a full-width separator line. if last status was non-0, make it red:
    echo $separator_color
    string pad -w$COLUMNS --char=─ ''
    # string pad -w$COLUMNS --char=_ '' # alternate: using an underscore characte    # string pad -w$COLUMNS --char=_ '' # alt charatr

    ### print main prompt; last exit status (if non zero) // current dir // git branch and status icon:
    echo -s $prompt_status $status_color $prefix ' ' (git_display) ' ' $cwd_color (prompt_pwd)

    ### an empty extra newline for user input:
    echo -n -s $normal
end

function git_display --description 'Format the git status display'
  # modifed, og from Terlar prompt
  set -q __fish_git_prompt_showdirtystate
  or set -g __fish_git_prompt_showdirtystate 1

  set -q __fish_git_prompt_showuntrackedfiles
  or set -g __fish_git_prompt_showuntrackedfiles 1

  set -q __fish_git_prompt_showcolorhints
  or set -g __fish_git_prompt_showcolorhints 1

  set -q __fish_git_prompt_color_untrackedfiles
  or set -g __fish_git_prompt_color_untrackedfiles yellow

  set -q __fish_git_prompt_char_untrackedfiles
  or set -g __fish_git_prompt_char_untrackedfiles '?'

  set -q __fish_git_prompt_color_invalidstate
  or set -g __fish_git_prompt_color_invalidstate red

  set -q __fish_git_prompt_char_invalidstate
  or set -g __fish_git_prompt_char_invalidstate '!'

  set -q __fish_git_prompt_color_dirtystate
  or set -g __fish_git_prompt_color_dirtystate yellow

  set -q __fish_git_prompt_char_dirtystate
  or set -g __fish_git_prompt_char_dirtystate '●'

  set -q __fish_git_prompt_char_stagedstate
  or set -g __fish_git_prompt_char_stagedstate '✚'

  set -q __fish_git_prompt_color_cleanstate
  or set -g __fish_git_prompt_color_cleanstate green

  set -q __fish_git_prompt_char_cleanstate
  or set -g __fish_git_prompt_char_cleanstate ' ✓'

  set -q __fish_git_prompt_color_stagedstate
  or set -g __fish_git_prompt_color_stagedstate yellow

  set -q __fish_git_prompt_color_branch_dirty
  or set -g __fish_git_prompt_color_branch_dirty yellow

  set -q __fish_git_prompt_color_branch_staged
  or set -g __fish_git_prompt_color_branch_staged yellow

  set -q __fish_git_prompt_color_branch
  or set -g __fish_git_prompt_color_branch green

  set -q __fish_git_prompt_char_stateseparator
  or set -g __fish_git_prompt_char_stateseparator ' '

  fish_vcs_prompt '%s'
end

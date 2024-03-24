function fish_prompt
    set --global __fish_git_prompt_show_informative_status true
    
    set --global last_status $status
    set --global line_colour red
    set --global block_opener '🮤'
    set --global block_closer '🮥'
    set --global block_internal_seperator '|'
    set --global prompt_finisher '>'

    function _print_block_single
        set -l content $argv[1]

        set_color $line_colour
        echo -n '─'
        set_color -o $line_colour
        echo -n $block_opener
        set_color blue
        test -n $content; and echo -n $content
        set_color -o $line_colour
        echo -n $block_closer
    end

    function _print_block_double
        set -l left_side $argv[1]
        set -l right_side $argv[2]

        set_color $line_colour
        echo -n '─'
        set_color -o $line_colour
        echo -n $block_opener
        set_color blue
        test -n $left_side; and echo -n $left_side
        set_color -o $line_colour
        echo -n $block_internal_seperator
        set_color green
        echo -n $right_side
        set_color -o $line_colour
        echo -n $block_closer
    end

    # Initial line so that start of prompt is two lines long
    set_color $line_colour
    echo -n '─'

    # user and working directory
    _print_block_double $USER (prompt_pwd)

    # current time
    _print_block_single (date +%H:%M)

    # git TODO: Fix and improve this! ideally it would look like <git|branch|staged|unstaged>
    set -l git_prompt (fish_git_prompt '%s')
    test -n "$git_prompt"
    and _print_block_double git $git_prompt

    # last command status
    test $last_status -ne 0
    and _print_block_double stat $last_status

    set_color $line_colour
    echo -n '──'
    echo
    echo -n ' '
    echo -n $prompt_finisher 
    echo -n ' '
    set_color normal

    # erasing them to prevent them being used in the shell
    set --erase last_status
    set --erase line_colour
    set --erase block_opener
    set --erase block_closer
    set --erase block_internal_seperator
    set --erase prompt_finisher
end

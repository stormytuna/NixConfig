function fish_prompt
    set --global line_colour red
    set --global block_opener '🮤'
    set --global block_closer '🮥'
    set --global block_internal_seperator '|'
    set --global prompt_finisher '>'

    function _print_block
        set -l field_name $argv[1]
        set -l field_value $argv[2]

        set_color $line_colour
        echo -n '─'
        set_color -o $line_colour
        echo -n $block_opener
        set_color blue
        test -n $field_name; and echo -n $field_name
        set_color -o $line_colour
        echo -n $block_internal_seperator
        set_color green
        echo -n $field_value
        set_color -o $line_colour
        echo -n $block_closer
    end

    # Initial line so that start of prompt is two lines long
    set_color $line_colour
    echo -n '─'

    # user and working directory
    _print_block $USER (prompt_pwd)

    # git TODO: Fix and improve this! ideally it would look like <git|branch|staged|unstaged>
    set -l git_prompt (fish_git_prompt '%s')
    if test ! -z '$git_prompt'
        _print_block git $git_prompt
    end

    # last command status
    if test $status -ne 0
        _print_block stat $status
    end

    set_color $line_colour
    echo -n '──'
    echo
    echo -n ' '
    echo -n $prompt_finisher 
    echo -n ' '
    set_color normal

    # erasing them to prevent them being used in the shell
    set --erase line_colour
    set --erase block_opener
    set --erase block_closer
    set --erase block_internal_seperator
    set --erase prompt_finisher
end

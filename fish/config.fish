function fish_greeting
    # neofetch
end

fish_vi_key_bindings
set -g fish_cursor_default     block
set -g fish_cursor_insert      line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_visual      block

set -x PATH $PATH /usr/local/go/bin $HOME/go/bin
set -x PATH $PATH $HOME/.cargo/bin
set -x CPM_SOURCE_CACHE $HOME/.cache/CPM
set -x VIM_TRANSPARENT 1

# aliases
alias please 'echo sudo $history[1] && eval command sudo $history[1]'
alias ..     'cd ..'
alias ...    'cd ../..'
alias ....   'cd ../../..'
alias .....  'cd ../../../..'

if type -q nvim;    alias vim 'NO_LAZY=ON nvim'; end
if type -q bat;     alias cat "bat -p"; end
if type -q batcat;  alias bat batcat; alias cat "batcat -p"; end
if type -q fd-find; alias fd fd-find; end

if type -q eza
    alias ls 'eza -g --group-directories-first'
    alias la 'eza -ga --group-directories-first'
    alias ll 'eza -gl --group-directories-first'
    alias lt 'eza -gT --group-directories-first'
    alias lla 'eza -gla --group-directories-first'
    alias llt 'eza -glT --group-directories-first'
    if not type -q tree; alias tree 'eza --tree --group-directories-first'; end
else if type -q exa
    alias ls 'exa -g --group-directories-first'
    alias la 'exa -ga --group-directories-first'
    alias ll 'exa -gl --group-directories-first'
    alias lt 'exa -gT --group-directories-first'
    alias lla 'exa -gla --group-directories-first'
    alias llt 'exa -glT --group-directories-first'
    if not type -q tree; alias tree 'exa --tree --group-directories-first'; end
else
    alias ls 'ls -g --color=auto'
    alias la 'ls -ga --color=auto'
    alias ll 'ls -gl --color=auto'
    alias lt 'ls -gR --color=auto'
    alias lla 'ls -gla --color=auto'
    alias llt 'ls -glR --color=auto'
end

# gemini
function gemini
    argparse 'f/file=' 'x/xclip' 'v/verbose' 'l/long' -- $argv
    or return

    if set -q _flag_long
        set pre_prompt ""
    else
        set pre_prompt "answer shortly\n"
    end

    set prompt "$pre_prompt$argv"
    if test (count $argv) -eq 0; and not isatty stdin
        while read line
            set prompt "$prompt\n$line"
        end
    end

    if set -q _flag_file
        if test -f $_flag_file
            set prompt "$prompt\n$(cat $_flag_file)"
        else
            echo "Error: File '$_flag_file' not found."
            exit 1
        end
    end

    if set -q _flag_xclip
        set prompt "$prompt\n$(xclip -selection clipboard -o)"
    end

    set api_url "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash-lite:generateContent"
    set prompt_json (echo $prompt | jq -Rsa .)
    if set -q _flag_verbose
        printf "prompt:\n$prompt\n\n"
        printf "response:\n"
    end

    curl -s "$api_url?key=$GEMINI_API_KEY" \
        -H "Content-Type: application/json" \
        -X POST \
        -d "{\"contents\":[{\"parts\":[{\"text\":$prompt_json}]}]}" \
        | jq -r '.candidates[0].content.parts[0].text // .error.message'
end

function qwen
    argparse 'f/file=' 'x/xclip' 'v/verbose' 'l/long' -- $argv
    or return

    if set -q _flag_long
        set pre_prompt ""
    else
        set pre_prompt "answer shortly\n"
    end

    set prompt "$pre_prompt$argv"
    if test (count $argv) -eq 0; and not isatty stdin
        while read line
            set prompt "$prompt\n$line"
        end
    end

    if set -q _flag_file
        if test -f $_flag_file
            set prompt "$prompt\n$(cat $_flag_file)"
        else
            echo "Error: File '$_flag_file' not found."
            exit 1
        end
    end

    if set -q _flag_xclip
        set prompt "$prompt\n$(xclip -selection clipboard -o)"
    end

    set api_url "http://localhost:11434/api/generate"
    set prompt_json (echo $prompt | jq -Rsa .)
    if set -q _flag_verbose
        printf "prompt:\n$prompt\n\n"
        printf "response:\n"
    end

    curl -s "$api_url" \
        -H "Content-Type: application/json" \
        -X POST \
        -d "{\"prompt\":$prompt_json,\"model\":\"qwen2.5:0.5b\",\"stream\":false}" \
        | jq -r '.response // .error'
end

function gemma
    argparse 'f/file=' 'x/xclip' 'v/verbose' 'l/long' -- $argv
    or return

    if set -q _flag_long
        set system_prompt ""
    else
        set system_prompt "Answer shortly."
    end

    set prompt "$argv"
    if test (count $argv) -eq 0; and not isatty stdin
        while read line
            set prompt "$prompt\n$line"
        end
    end

    if set -q _flag_file
        if test -f $_flag_file
            set prompt "$prompt\n"(cat $_flag_file)
        else
            echo "Error: File '$_flag_file' not found."
            return 1
        end
    end

    if set -q _flag_xclip
        set prompt "$prompt\n"(xclip -selection clipboard -o)
    end

    set system_json (printf "%s" "$system_prompt" | jq -Rsa .)
    set prompt_json (printf "%s" "$prompt" | jq -Rsa .)

    if set -q _flag_verbose
        printf "prompt:\n%s\n\n" "$prompt"
        printf "response:\n"
    end

    curl -s http://localhost:11434/v1/chat/completions \
        -H "Content-Type: application/json" \
        -d "{
            \"model\": \"gemma3:1b\",
            \"messages\": [
                {\"role\": \"system\", \"content\": $system_json},
                {\"role\": \"user\", \"content\": $prompt_json}
            ]
        }" \
        | jq -r '.choices[0].message.content // .error.message'
end

function commit
    argparse 'l/long' 'c/context=' -- $argv
    or return

    if set -q _flag_long
        set prompt "
        Write a git commit message using this format:

        <emoji> <short subject>

        <body explaining what and why>

        Rules:
        - you must infer the appropriate emoji based on the type of change
        - imperative mood
        - subject <= 72 chars
        - no trailing period in subject
        - blank line between subject and body
        - body wrapped at ~72 chars
        - do not repeat the subject in body

        Emoji guide:
        🐛 fix: bug fix
        ♻️ refactor: code change without behavior change
        ⚡ perf: performance improvement
        📝 docs: documentation only
        🎨 style: formatting / lint
        ✅ test: add/update tests
        🔧 chore: build/config/tooling
        🚀 ci: CI/CD changes
        ✨ feat: new feature
        "
    else
        set prompt "
        Write a single-line git commit message.

        Rules:
        - you must infer the appropriate emoji based on the type of change
        - output only one line
        - format: <emoji> <imperative subject>
        - no body
        - no quotes
        - no trailing period
        - <= 72 characters
        - be specific and concise

        Emoji guide:
        🐛 fix
        ♻️ refactor
        ⚡ perf
        📝 docs
        🎨 style
        ✅ test
        🔧 chore
        🚀 ci
        🔥 remove
        ✨ feat
        "
    end

    if set -q _flag_context
        set formatted (string join "\n- " $_flag_context)

        set prompt "$prompt

        Additional context:
        - $formatted
        "
    end

    set diff (git diff --staged --unified=0 | string collect)
    set msg (printf "%s\n%s" "$prompt" "$diff" | gemini -l | string collect)

    echo "message:"
    echo "$msg"

    read -P "Commit with this message? [y/N] " confirm
    switch $confirm
    case y Y
        if set -q _flag_long
            printf "%s" "$msg" | git commit -F -
        else
            git commit -m (printf "%s" "$msg" | head -n1)
        end
    case e E
        set tmpfile (mktemp)
        printf "$s\n" "$msg" > $tmpfile
        git commit -v -e -F $tmpfile
        rm $tmpfile
    case '*'
        return 1
    end
end

# extract
function ex
    if test (count $argv) -eq 0
        echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|exe|tar.bz2|tar.gz|tar.xz>"
        echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
        return
    end

    for n in $argv
        if test -f "$n"
            switch "$n"
            case '*.tar.bz2' '*.tar.gz' '*.tar.xz' '*.tbz2' '*.tgz' '*.txz' '*.tar'
                tar xvf "$n"
            case '*.lzma'
                unlzma "$n"
            case '*.bz2'
                bunzip2 "$n"
            case '*.rar' '*.cbr'
                unrar x -ad "$n"
            case '*.gz'
                gunzip "$n"
            case '*.zip' '*.cbz' '*.epub'
                unzip "$n"
            case '*.z'
                uncompress "$n"
            case '*.7z' '*.arj' '*.cab' '*.cb7' '*.chm' '*.deb' '*.dmg' '*.iso' '*.lzh' '*.msi' '*.pkg' '*.rpm' '*.udf' '*.wim' '*.xar'
                7z x "$n"
            case '*.xz'
                unxz "$n"
            case '*.exe'
                cabextract "$n"
            case '*.cpio'
                cpio -id < "$n"
            case '*.ace' '*.cba'
                unace x "$n"
            case '*'
                echo "ex: '$n' - unknown archive method"
                return 1
            end
        else
            echo "'$n' - file does not exist"
            return 1
        end
    end
end

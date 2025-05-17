#!/bin/bash
# Define session names and directories
declare -A sessions
sessions["cp"]="$HOME/cp"       # Competitive Programming workspace
sessions["notes"]="$HOME/notes" # Notes and documentation
sessions["dev"]="$HOME/dev"     # Development projects

# Function to create a new session if it doesn't exist
create_session() {
	local name=$1
	local dir=$2

	# Check if session exists
	tmux has-session -t $name 2>/dev/null

	# If session doesn't exist, create it
	if [ $? != 0 ]; then
		# Create directory if it doesn't exist
		mkdir -p "$dir"

		# Create session
		tmux new-session -d -s $name -c "$dir"

		# Configure based on session type
		case $name in
		"cp")
			# CP session: editor + compiler output
			tmux rename-window -t $name:1 'code'
			tmux send-keys -t $name:1 'nvim' C-m
			tmux new-window -t $name -c "$dir" -n 'run'
			tmux send-keys -t $name:2 'clear' C-m
			tmux split-window -t $name:2 -h -c "$dir"
			tmux send-keys -t $name:2.2 'echo "Test cases"' C-m
			tmux select-window -t $name:1
			;;
		"notes")
			# Notes session: just editor
			tmux rename-window -t $name:1 'notes'
			tmux send-keys -t $name:1 'nvim' C-m
			;;
		"dev")
			# Dev session: editor + terminal + server
			tmux rename-window -t $name:1 'code'
			tmux send-keys -t $name:1 'nvim' C-m
			tmux new-window -t $name -c "$dir" -n 'term'
			tmux new-window -t $name -c "$dir" -n 'server'
			tmux select-window -t $name:1
			;;
		esac

		echo "Session $name created!"
	else
		echo "Session $name already exists!"
	fi
}

# Display session selection menu using fzf
selected=$(printf "%s\n" "${!sessions[@]}" | sort | fzf --prompt="Create session: " --height=40% --layout=reverse --border)

# Create selected session
if [ -n "$selected" ]; then
	create_session "$selected" "${sessions[$selected]}"
	tmux switch-client -t "$selected"
fi

# HARBOR-LOGIN
harbor-login(){
    echo $HARBOR_TOKEN | docker login -u me13870l --password-stdin https://repository.cloud-factory.dma.dsit.aws.internal.cloud.edf.fr/
}

# EDOC_FZF_JUMP
edoc_fzf_jump() {
  local workspace="$HOME/dev/edoc-workspace"
  local modules_dir="$workspace/edoc-modules"
  local choices=()

  # Include edoc-application if it exists
  [[ -d "$workspace/edoc-application" ]] && choices+=("edoc-application")

  # Include only subdirectories of edoc-modules
  for dir in "$modules_dir"/*(/); do
    choices+=("${dir##*/}")
  done

  # Prompt with fzf
  local selected=$(printf '%s\n' "${choices[@]}" | fzf --prompt="SELECT A PROJECT > ")
  [[ -z "$selected" ]] && return

  # Navigate to the selected directory
  local target_dir="$workspace/edoc-application"
  [[ "$selected" != "edoc-application" ]] && target_dir="$modules_dir/$selected"

  cd "$target_dir"
}

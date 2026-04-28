# Open repository in browser if on tangled.org
# (Essentially `gh repo view --web` for Tangled)
function tangled() {
  local remote
  remote=$(git remote get-url origin 2>/dev/null) || { echo "not a git repo or no origin"; return 1; }

  if [[ "$remote" != *tangled.org* ]]; then
    echo "origin is not tangled.org"
    return 1
  fi

  local repo_path
  repo_path=$(echo "$remote" | sed -E 's|.*tangled\.org[:/]||; s|\.git$||')
  open "https://tangled.org/$repo_path"
}

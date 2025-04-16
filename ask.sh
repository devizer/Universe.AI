set -eu -o pipefail;
model="$1"
query="$2"
startMe="$(mktemp -t Start-Me.XXXXXXXXXXXX.sh)"
echo '
ollama run "$MODEL" "$QUERY" | cat
' > "$startMe"
docker cp "$startMe" ollama:/start-me.sh
docker exec -e MODEL="$model" -e QUERY="$query" ollama bash -eu -o pipefail /start-me.sh

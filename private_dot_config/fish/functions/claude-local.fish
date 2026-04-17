# claude-local - runs this version of claude with custom env vars
function claude-local
    set -l base_url 'http://0.0.0.0:6960'
    if test -f /etc/alpine-release
        set base_url 'http://192.168.64.1:6960'
    end

    ANTHROPIC_BASE_URL="$base_url" \
    ANTHROPIC_AUTH_TOKEN='antigfrigil' \
    ANTHROPIC_DEFAULT_OPUS_MODEL='Qwen3.5-35B-A3B-4bit' \
    ANTHROPIC_DEFAULT_SONNET_MODEL='Qwen3.5-35B-A3B-4bit' \
    ANTHROPIC_DEFAULT_HAIKU_MODEL='Qwen3.5-0.8B-4bit' \
    API_TIMEOUT_MS=3000000 \
    CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 \
    claude $argv
end

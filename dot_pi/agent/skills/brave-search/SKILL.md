---
name: brave-search
description: Web search and content extraction via Brave Search API by using `bx context` followed by the query. Use for searching documentation, facts, or any web content. Lightweight, no browser required.
---

# Brave Search

Web search and content extraction using the official Brave Search API. No browser required.

## Setup

**macOS/Linux**

```bash
curl -fsSL https://raw.githubusercontent.com/brave/brave-search-cli/main/scripts/install.sh | sh
```

**Windows (PowerShell)**

```powershell
powershell -ExecutionPolicy Bypass -c "irm https://raw.githubusercontent.com/brave/brave-search-cli/main/scripts/install.ps1 | iex"
```

```bash
bx config set-key YOUR_API_KEY    # get a key at https://api-dashboard.search.brave.com
bx "your search query"            # shorthand for: bx context "your search query"
bx --help
# see all commands; bx <command> --help for flags
```

## Search

```bash
bx context "query"                         # Basic search (5 results)
bx context "query" --max-tokens 4986
bx context "query" --count 10               # Include page content as markdown
bx context "query" --country DE            # Results from Germany
```

### Options

- `--country <COUNTRY>` - Country code
- `--search-lang <SEARCH_LANG>` - Search language
- `--count <COUNT>` - Number of results
- `--max-urls <MAXIMUM_NUMBER_OF_URLS>` - Max URLs to include
- `--timeout <TIMEOUT>` - Request timeout in seconds [default: 30]
- `--max-tokens <MAXIMUM_NUMBER_OF_TOKENS>` - Max total tokens
- `--max-snippets <MAXIMUM_NUMBER_OF_SNIPPETS>` - Max snippets
- `--max-tokens-per-url <MAXIMUM_NUMBER_OF_TOKENS_PER_URL>` - Max tokens per URL
- `--max-snippets-per-url <MAXIMUM_NUMBER_OF_SNIPPETS_PER_URL>` - Max snippets per URL
- `--goggles <GOGGLES>` - Goggles: custom re-ranking rules — boost, downrank, or discard results.
  Target by domain (site=) or URL path pattern (/docs/$boost=3).
          Actions: $boost=N (1-10), $downrank=N (1-10), $discard. One rule per line.
          Repeatable: --goggles '$site=docs.rs' --goggles '$discard' (joined with newlines)
          Inline:    --goggles '$boost=3,site=docs.python.org' (use \n for multiple rules)
  File: --goggles @rules.goggle (reads local file, ideal for agents)
  Stdin: --goggles @- (reads from stdin)
  Hosted: --goggles 'https://raw.githubusercontent.com/.../my.goggle'
  Unique to Brave — no other search API offers custom re-ranking.
  Mutually exclusive with --include-site / --exclude-site.
  Ref: https://github.com/brave/goggles-quickstart

- `--include-site <INCLUDE_SITE>` - Only include results from these domains (repeatable, exclusive with --goggles / --exclude-site)
- `--exclude-site <EXCLUDE_SITE>` - Exclude results from these domains (repeatable, exclusive with --goggles / --include-site)

## Output Format

```
{
  "grounding": {
    "generic": [
      { "url": "...", "title": "...", "snippets": ["extracted content...", "..."] }
    ]
  }
}
```

## Exit Codes

| Code | Meaning                         | Agent action                                |
| ---- | ------------------------------- | ------------------------------------------- |
| 0    | Success                         | Process results                             |
| 1    | Client error (bad request)      | Fix query/parameters                        |
| 2    | Usage error (bad flags)         | Fix CLI arguments (clap)                    |
| 3    | Auth/permission error (401/403) | Check API key or plan: `bx config show-key` |
| 4    | Rate limited (429)              | Retry after delay                           |
| 5    | Server/network error            | Retry with backoff                          |

## Error Handling

Errors are printed to stderr with a human-readable summary, recovery hints, and the full JSON error body:

```
error: rate limited (429) — Request rate limit exceeded for plan.
hint: retry after a short delay, or upgrade plan for higher rate limits
{"type":"ErrorResponse","error":{"code":"RATE_LIMITED","status":429,...}}
```

Exit codes are differentiated — see [Exit Codes](#exit-codes) above.

## When to Use

- Searching for documentation or API references
- Looking up facts or current information
- Fetching content from specific URLs
- Any task requiring web search without interactive browsing

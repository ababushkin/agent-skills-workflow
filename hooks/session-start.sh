#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GOVERNANCE="$SCRIPT_DIR/../rules/GOVERNANCE.md"

python3 - "$GOVERNANCE" <<'EOF'
import json, sys
path = sys.argv[1]
try:
    with open(path) as f:
        content = f.read()
    print(json.dumps({"priority": "IMPORTANT", "message": content}))
except Exception as e:
    print(json.dumps({"priority": "INFO", "message": "workflow: rules/GOVERNANCE.md not found"}))
EOF

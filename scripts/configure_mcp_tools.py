#!/usr/bin/env python3
"""
configure_mcp_tools.py — lightweight, local-only MCP tool mapping helper

This script edits mcp.tools.json in-place to toggle optional MCP servers
described by the project. It does not contact any network service; it just
updates the local JSON mapping so humans (and project docs) stay in sync.

Modes:
  --apply-json     Validate and pretty-print the current JSON. No changes.
  --interactive    Prompt to enable/disable optional tools (octocode, sequential-thinking)
  --list           Show current agent→tools mapping.

Note: Claude Code picks up MCP servers from your CLI/editor configuration.
This file is documentation of intended defaults, not a live config source.
"""
import argparse, json, os, sys
from typing import Dict, List
import copy

PATH = "mcp.tools.json"

def load() -> Dict:
    if not os.path.exists(PATH):
        print(f"mcp.tools.json not found at {PATH}", file=sys.stderr)
        sys.exit(1)
    with open(PATH, "r", encoding="utf-8") as f:
        return json.load(f)

def save(data: Dict) -> None:
    with open(PATH, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
        f.write("\n")

def list_mapping(data: Dict) -> None:
    print("Agents → tools:\n")
    agents: Dict[str, List[str]] = data.get("agents", {})
    for name, tools in agents.items():
        print(f"- {name}: {', '.join(tools)}")

def interactive(data: Dict) -> None:
    agents: Dict[str, List[str]] = data.setdefault("agents", {})
    optional = ["octocode", "sequential-thinking"]
    before = copy.deepcopy(agents)
    print("\nToggle optional MCP tools per agent (octocode, sequential-thinking).\n")
    for agent in agents.keys():
        tools = set(agents.get(agent, []))
        for opt in optional:
            current = opt in tools
            ans = input(f"Agent '{agent}': {opt} is {'ON' if current else 'off'}. Toggle? [y/N] ").strip().lower()
            if ans == "y":
                if current:
                    tools.remove(opt)
                else:
                    tools.add(opt)
        agents[agent] = list(tools)
    save(data)
    # Compute a summary of changes
    changes: List[str] = []
    for agent in sorted(set(before.keys()) | set(agents.keys())):
        prev = set(before.get(agent, []))
        cur = set(agents.get(agent, []))
        added = sorted(list(cur - prev))
        removed = sorted(list(prev - cur))
        if added or removed:
            if added:
                changes.append(f"- {agent}: enabled {', '.join(added)}")
            if removed:
                changes.append(f"- {agent}: disabled {', '.join(removed)}")
    if changes:
        print("\nChanges:\n" + "\n".join(changes))
    else:
        print("\nNo changes.")
    print("\nUpdated mcp.tools.json.")

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply-json", action="store_true", help="Validate and pretty-print current JSON")
    ap.add_argument("--interactive", action="store_true", help="Interactively toggle optional tools")
    ap.add_argument("--list", action="store_true", help="List current mapping")
    args = ap.parse_args()

    data = load()
    if args.apply_json:
        save(data)
        print("Applied defaults from mcp.tools.json (validated & pretty-printed).")
        return
    if args.interactive:
        interactive(data)
        return
    if args.list:
        list_mapping(data)
        return
    ap.print_help()

if __name__ == "__main__":
    main()

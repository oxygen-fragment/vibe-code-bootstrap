# Makefile — optional helpers
.PHONY: start init plan build review help doctor tools

start:
	@python3 scripts/vibe_onboarding.py

init:
	@echo "/project:init"

plan:
	@echo "/project:plan"

build:
	@echo "/project:build"

review:
	@echo "/project:review"

help:
	@echo "/project:help"

doctor:
	@echo "/project:doctor"

tools:
	@python3 scripts/configure_mcp_tools.py --list

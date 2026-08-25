---
title: "difr"
description: "A Go command-line tool for golden-file testing. Test cases are folders, expected output is a file, and accepting a change leaves a normal Git diff."
status: "Experiment, complete"
featured: 3
source: "https://github.com/vetr0s/difr"
---

difr is a golden-file test runner for command-line programs. A test case names a
command, optional standard input, and the output it should produce. difr runs the
command and shows a line diff when the result changes.

The update command replaces expected files with actual output. Review then
happens in version control, where it is visible and reversible. The tool does
not add an approval database or hide accepted changes in its own format.

This was a focused experiment in command-line interface design and small Go
package boundaries. Version 1 is complete. I am not actively extending it.

## What I worked on

- Folder-convention test discovery with nested groups and local fixture files
- A longest-common-subsequence line diff with terminal color support
- Separate exit codes for test failures and runner errors
- Interfaces at the two intended extension points: case loading and comparison
- Golden tests for the tool's own command output

The small scope was deliberate. Exact standard-output comparison is useful on
its own, and the package layout leaves room for other comparators without making
version 1 carry them.

- [Source](https://github.com/vetr0s/difr)
- [Install and usage](https://github.com/vetr0s/difr#quickstart)

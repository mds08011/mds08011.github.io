# Project instructions for Claude

This is a hand-coded, zero-dependency static site (semantic HTML5 + vanilla CSS/JS,
no build step). See `README.md` for the full Publishing SOP. The notes below are
agent-facing conventions layered on top of it.

## Tool screenshots — generate by default for new tools

**When a new single-file tool is added to `/tools` and gets a blog post, produce a
real screenshot of the tool and wire it into the post's `<figure>` by default.** Do
not leave a `/path/to/...` placeholder for a tool that can be screenshotted. Only
leave a placeholder when the figure is genuinely something we can't render (a field
photo, an external app, a diagram) — and when you do, tell the user which ones and why.

### How to capture (the pipeline that works on this machine)

Headless Chrome renders these self-contained tools cleanly (it honors
`prefers-color-scheme: dark`). Neither Node nor Python is installed here; drive it
from Git Bash.

1. **Populate the tool first.** An empty form doesn't match the caption. Inject a
   small `<script>` right after `<body>` that either seeds `localStorage` (for
   row-builder/log tools — use the tool's own `LS_KEY` and state shape so it loads
   through its real code path) or, on `window`'s `load` event, sets the input
   `value`s and dispatches `input`/`change` events. Pick representative, realistic
   inputs so the visible result matches the figure's caption. Crop off everything
   from the first `<h2>How the Numbers…</h2>` / `<h2>Notes</h2>` onward so the shot
   is just the tool UI.
2. **Render to a PNG** into the post's own dated directory, at 2× for sharpness:
   ```
   chrome --headless=new --disable-gpu --hide-scrollbars \
     --force-device-scale-factor=2 --window-size=820,<height> \
     --screenshot="blog/<YYYY-MM-DD>/<tool>.png" "file:///.../t_<tool>.html"
   ```
   Chrome captures the full page up to `<height>` CSS px — size it to fit the tool
   plus its result panel. Build the injected temp copy in the scratchpad, not the repo.
3. **Verify by eye.** Read the PNG back and confirm it's populated, the result matches
   the caption, and nothing is cut off. `<select>` values must be the option's real
   `value` (often a code like `16510` for 8 AWG, not the label). Re-shoot if a value
   didn't take or the panel is clipped.
4. **Wire it in.** Set the `<figure>`'s `<img src>` to the absolute site path
   `/blog/<YYYY-MM-DD>/<tool>.png` (matching how posts link to `/tools/...`). Keep the
   existing descriptive `alt` and `<figcaption>`; keep `loading="lazy"`.
5. **Commit** the PNG and the post edit together. Don't push unless asked.

### What can't be auto-screenshotted (leave a placeholder, list it for the user)

- **Field photos** — e.g. a wet-well float setup, a weir plate in a channel, a
  confined-space blower. These need real photos.
- **External apps** — e.g. gifcap.dev, GoldFynch PST viewer. Don't fabricate these.
- **Terminal how-tos** — a real terminal capture of a command's output.
- **File-upload-only tools** (image-to-jpeg, exif, image-print, tiff-orientation,
  image-to-svg, OCR without an example button): the meaningful output needs a user
  file, so an empty upload state won't match the caption. Skip unless the tool has a
  "load example" button that self-populates.

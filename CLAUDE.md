# Project instructions for Claude

This is a hand-coded, zero-dependency static site (semantic HTML5 + vanilla CSS/JS,
no build step). See `README.md` for the tone/formatting SOP. The notes below are the
agent-facing conventions we actually follow — they layer on top of the README and, where
noted, supersede it.

## Blog posts — structure and workflow

**File location.** One post per dated directory: `/blog/<YYYY-MM-DD>/<slug>.html`. The
directory date is the stable sort key; the slug usually matches the tool's filename.

**Posts are full standalone HTML pages, not `<main>` fragments.** (This supersedes the
README's "content inside `<main>` only" line, which describes an older intent — every real
post is a complete page.) Copy the skeleton from a recent post like
`blog/2026-07-07/tiff-orientation.html`: `sakura.css` + `/style.css`, the goatcounter
script, the shared `<nav>` header, then `<main><article><header><h1>…</h1>
<time datetime="…">…</time></header> …content… </article></main>`, then the shared footer.

**Body structure and voice.** Open with `<h2>The Problem</h2>`, then the approach / the
governing formula in `<code>`, and lead with the one notable implementation detail. Keep it
to ~4–8 short paragraphs plus one `<figure loading="lazy">` (see the screenshot section
below), a `<details>` block for any dense field-notes/gotcha list, and an
`<h3>References</h3>` at the end. Tone: practical, slightly nerdy, accessible — a civil
engineer explaining a cool workaround to a friend. Match the length and voice of existing
posts; don't invent a new structure.

**Titles and descriptions** stay dry and functional — state what the tool does, no marketing.

**Citations (TexLive style).** No inline hyperlinks in body prose; use bracketed `[n]`
markers, and put the actual links in the `<h3>References</h3>` list at the bottom. Source
those references from the tool's own References section — never fabricate a standard/citation.
The one allowed inline link is a pointer to the tool itself (`/tools/<slug>.html`).

**Dates display as month-and-year for 2026 posts.** On the blog index, `<time>YYYY-MM</time>`;
on the page, "Month YYYY" (or `YYYY.MM`) with a full `datetime="YYYY-MM-DD"` attribute. When
backdating a batch, spread the real directory dates naturally across the months so the index
shows a gradual cadence, and confirm the spread with the user before writing all the posts.

**Wire every post into the indexes.** Add to `/blog/index.html` newest-first, under the year
header (`<h4><strong>2026</strong></h4>`), format
`<li><a href="/blog/<date>/<slug>.html"><time>YYYY-MM</time> Title</a></li>`. For a tool, also
add it to `/tools/index.html` under the right category `<h4><strong>…</strong></h4>` header
(Startup &amp; Commissioning, Hydraulics &amp; Pumping, Quantities &amp; Ordering, Field QC
&amp; Testing, Safety/Compliance/Tracking, Controls &amp; Networking, Hydrology &amp;
Drainage, GIS &amp; Mapping, Web Utilities).

**Before generating a large batch,** report what you found (file/index patterns, date spread)
and get confirmation, so you don't write many posts against a misread pattern.

**Commits.** Split logically (e.g. tools + index / posts / index updates), author as the user
only (no `Co-Authored-By` trailer), and don't push unless asked.

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

### File-upload tools — inject a synthetic file, don't skip

Tools that only take a file (image-to-jpeg, image-print, svg-render, exif,
tiff-orientation…) can still be captured: synthesize the input in the injected script
and hand it to the file input as if the user picked it. Draw a canvas, `toBlob`/`toDataURL`
it, wrap it in a `File`, and load it via a `DataTransfer`:

```js
var dt = new DataTransfer();
dt.items.add(new File([blob], 'photo.jpg', { type: 'image/jpeg' }));
var inp = document.getElementById('fileInput');   // the tool's real input id
inp.files = dt.files;
inp.dispatchEvent(new Event('change', { bubbles: true }));
```

For tools that read **metadata** (exif GPS, tiff-orientation), a plain canvas JPEG has
none — hand-build a little-endian TIFF/EXIF `APP1` segment (`FF E1 … "Exif\0\0" … II 2A00
…`) with the tags you want (Orientation `0x0112`, GPS IFD `0x8825` with lat/lon
RATIONALs) and splice it in right after the SOI (`FF D8`). The values are fabricated demo
data — fine for a screenshot, and worth a caption that doesn't claim otherwise. Give
async work (`toBlob`, WASM) time with `--virtual-time-budget=<ms>`.

### What genuinely can't be auto-screenshotted (leave a placeholder, list it for the user)

- **Field photos** — e.g. a wet-well float setup, a weir plate in a channel, a
  confined-space blower. These need real photos.
- **External apps** — e.g. gifcap.dev, GoldFynch PST viewer. Don't fabricate these.
- **Terminal how-tos** — a real terminal capture of a command's output.
- **Tools that fetch an example over the network** (OCR's "load example" hits a URL that
  a `file://` origin can't reach) or **load state from the URL + async WASM** (quickjs):
  they don't reach a finished state under headless automation. Skip and list them.

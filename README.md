# Site Architecture & Publishing Standard

This repository serves as a personal knowledge base and technical testing environment. It is governed by a strict, privacy-respecting philosophy focused on software independence and longevity.

## 1. Core Philosophy

The structural and architectural principles of this site are defined as follows:

- **Semantic Foundation:** All pages are hand-coded utilizing pure semantic HTML5 and minimal vanilla CSS.
- **Zero-Dependency Architecture:** There is absolutely NO JavaScript framework bloat (e.g., no React, no Tailwind). The site features no external tracking scripts and no server-side databases.
- **Client-Side Tooling:** Any web tools hosted within this domain are deployed as single-file, offline-capable applications utilizing vanilla JavaScript and local browser APIs exclusively.

## 2. Publishing Standard Operating Procedure (SOP)

To maintain uniformity and technical rigor, all future blog posts and tools must adhere to the following formatting specifications:

- **Tone Specification:** Titles and descriptions must be extremely dry, descriptive, and functional.
- **HTML5 Compliance:** Content must be authored to be pasted directly inside the master `<main>` tag. No `<head>` or `<!DOCTYPE html>` boilerplate is permitted for individual posts.
- **Native Element Usage:**
  - Standard HTML heading tags (`<h2>`, `<h3>`) must be utilized for document hierarchy.
  - Terminal and bash commands must be wrapped in `<pre><code>`.
  - Keyboard shortcuts must be enclosed in `<kbd>`.
  - Long terminal log outputs or dense troubleshooting sequences must be encapsulated using native `<details>` and `<summary>` tags.
- **Media Handling:** Image placeholders must be wrapped within a `<figure>` tag, include a descriptive `<figcaption>`, and enforce the `loading="lazy"` attribute.
- **Citation Standard (TexLive Format):** Hyperlinks must never be embedded inline within the primary text. Bracketed footnotes (e.g., [1]) must be used in the body, accompanied by a dedicated References section at the document's terminus containing the explicit URLs.

---

## Acknowledgements

- Kimberly for keeping me motivated by rolling her eyes as I work on this site.
- [oxalorg](https://github.com/oxalorg) for creating [sakura](https://github.com/oxalorg/sakura), the CSS used for this site.
- [octokatherine](https://www.github.com/octokatherine) for creating [https://readme.so](https://readme.so) which was used to structure this Readme.

## License

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://www.gnu.org/licenses/quick-guide-gplv3.html)
[GNU General Public License v3.0](https://github.com/mds08011/mds08011.github.io/blob/master/LICENSE)

## Appendix

Additional resources used in the creation of this website can be found here: https://malcolmdsmith.com/online/web-dev.html
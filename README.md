# Site Architecture & Publishing Standard

This repository serves as a personal knowledge base and technical testing environment. It is governed by a strict, privacy-respecting philosophy focused on software independence and longevity.

## 1. Core Philosophy

The structural and architectural principles of this site are defined as follows:

- **Semantic Foundation:** All pages are hand-coded utilizing pure semantic HTML5 and minimal vanilla CSS.
- **Zero-Dependency Architecture:** There is absolutely NO JavaScript framework bloat (e.g., no React, no Tailwind). The site has no server-side databases. The only third-party script is GoatCounter, a privacy-respecting counter with no cookies, and its numbers are public.
- **Client-Side Tooling:** Web tools on this domain are single-file vanilla JavaScript that runs in the browser. The engineering calculators work offline. Some web utilities (OCR, QuickJS, QR codes and others) load a library from a CDN, so they need a connection the first time.

## 2. Publishing Standard Operating Procedure (SOP)

To maintain uniformity and technical rigor, all future blog posts and tools must adhere to the following formatting specifications:

- **Tone Specification:** Titles and descriptions must be extremely dry, descriptive, and functional.
- **HTML5 Compliance:** Each post is a complete standalone page, copied from the skeleton of a recent post, with its content inside `<main><article>`.
- **Native Element Usage:**
  - Standard HTML heading tags (`<h2>`, `<h3>`) must be utilized for document hierarchy.
  - Terminal and bash commands must be wrapped in `<pre><code>`.
  - Keyboard shortcuts must be enclosed in `<kbd>`.
  - Long terminal log outputs or dense troubleshooting sequences must be encapsulated using native `<details>` and `<summary>` tags.
- **Page Weight:** Pages should load on a slow 2G connection. Photos are resized to 1280 px on the long edge at JPEG quality 75, with metadata stripped, before they are committed.
- **Media Handling:** Image placeholders must be wrapped within a `<figure>` tag, include a descriptive `<figcaption>`, and enforce the `loading="lazy"` attribute.
- **Citation Standard (TexLive Format):** Hyperlinks must never be embedded inline within the primary text. Bracketed footnotes (e.g., [1]) must be used in the body, accompanied by a dedicated References section at the document's terminus containing the explicit URLs.

---

## Acknowledgements

- Kimberly for keeping me motivated by rolling her eyes as I work on this site.
- [oxalorg](https://github.com/oxalorg) for creating [sakura](https://github.com/oxalorg/sakura), the CSS used for this site. A copy of v1.5.1 is kept at `/sakura.css` so pages do not depend on a CDN.
- [octokatherine](https://www.github.com/octokatherine) for creating [https://readme.so](https://readme.so) which was used to structure this Readme.

## License

[![GPLv3 License](https://img.shields.io/badge/License-GPL%20v3-yellow.svg)](https://www.gnu.org/licenses/quick-guide-gplv3.html)
[GNU General Public License v3.0](https://github.com/mds08011/mds08011.github.io/blob/master/LICENSE)

## Appendix

Additional resources used in the creation of this website can be found here: https://mds08011.github.io/online/web-dev.html
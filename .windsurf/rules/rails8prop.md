---
trigger: always_on
---



Ruby 3.4.5, Rails 8.0.2, PostgreSQL 14

Propshaft 1.2.1 (manifest) — no Sprockets.

Node ≥ 20, NPM-only (no Yarn).

Use jsbundling-rails (esbuild) and cssbundling-rails (PostCSS + Tailwind v4).

Never suggest importmap-rails or sprockets-rails.

CSS & UI choices (default to Tailwind + Elements)

Default: Tailwind CSS v4 classes + Tailwind Plus Elements for behavior.

Components: use <el-dropdown>, <el-menu popover anchor="…">, <el-disclosure id="…">, <el-dialog>, etc.

Only suggest Preline if I ask for it explicitly; otherwise no hs-* classes.


Elements-first interactivity (and a safety check)

For dropdown/menu/mobile nav, prefer Elements attributes (e.g., command="--toggle" commandfor="mobile-menu").

Before shipping a navbar: confirm Elements is loaded:

window.customElements.get('el-dropdown')


If undefined and I need a quick fallback, you may add (temporarily) in <head>:

<script type="module">
  if (!window.customElements.get('el-dropdown')) {
    import('https://cdn.jsdelivr.net/npm/@tailwindplus/elements@1');
  }
</script>


Authentication defaults

Use Devise (no “roll-your-own” unless requested).



If you must choose UI examples, pick from Tailwind v4 + Tailwind Plus (UI Blocks + Elements) by default; mention Preline only if requested.

If you follow these 10 rules, anything you generate should drop cleanly into my Rails 8 app and “just work” with Tailwind v4 + Tailwind Plus Elements.
# lexxy-youtube

YouTube embed extension for [Lexxy](https://github.com/OhayoStudio/lexxy) rich-text editors.

- Automatically converts pasted YouTube URLs to responsive iframe embeds
- Adds a toolbar button with a URL input dropdown for manual embeds
- Zero Ruby runtime dependencies — pure JS, ships as a Rails engine asset

## Requirements

- Rails 7.0+
- [Lexxy](https://github.com/OhayoStudio/lexxy) (peer dependency — must be set up in your app)
- Importmap Rails (standard in Rails 7+)

## Installation

Not published to RubyGems — install from GitHub:

```ruby
# Gemfile (next to your existing `gem "lexxy"`)
gem "lexxy-youtube", github: "OhayoStudio/lexxy-youtube"
```

```bash
bundle install
```

The Rails engine auto-pins the asset through its own importmap config, so you
**don't** add a `pin` in your app's `config/importmap.rb`. Confirm it resolved:

```bash
bin/importmap json | grep lexxy_youtube
# => "lexxy_youtube": "/assets/lexxy_youtube-<digest>.js"
```

## Usage

Import the extension right after Lexxy in `app/javascript/application.js`:

```js
import "lexxy"
import "lexxy_youtube"
```

That's it. The extension self-registers with Lexxy on import:

- **Paste a YouTube URL** anywhere in the editor → auto-converted to an embed
- **Toolbar button** (YouTube icon) → opens a URL input dropdown for manual embeds

Embeds render in the editor (including after saving and reopening) out of the
box — the extension whitelists its own markup with Lexxy's client-side
sanitizer.

## Action Text sanitizer

This is the one thing your app must configure. If you store the editor output
with Action Text, whitelist `<iframe>`/`<figure>` so embeds survive Action
Text's **server-side** sanitizer and render on public pages:

```ruby
# config/initializers/action_text_sanitizer.rb
Rails.application.config.after_initialize do
  ActionText::ContentHelper.allowed_tags  |= %w[ figure iframe ]
  ActionText::ContentHelper.allowed_attributes |= %w[
    src title frameborder allowfullscreen loading allow style
    class width height
  ]
end
```

## Troubleshooting

**Embed shows when inserted and on the public page, but reopening the saved
article in the editor leaves an empty figure (a "big space").** Your installed
version predates the editor-sanitizer fix — `bundle update lexxy-youtube`. (Lexxy
sanitizes HTML client-side with DOMPurify on load and strips `<iframe>` unless an
extension whitelists it; current versions declare this via `allowedElements`, so
it's handled internally.)

**Embed missing on the public page** but fine in the editor → you skipped the
Action Text sanitizer above.

## License

MIT

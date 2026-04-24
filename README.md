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

```ruby
# Gemfile
gem "lexxy-youtube"
```

```bash
bundle install
```

## Usage

Pin the JS in your importmap:

```ruby
# config/importmap.rb
pin "lexxy_youtube", to: "lexxy_youtube.js"
```

Import it in the layout or view where Lexxy is used:

```erb
<%= javascript_import_tag "lexxy_youtube" %>
```

That's it. The extension self-registers with Lexxy on import:

- **Paste a YouTube URL** anywhere in the editor → auto-converted to an embed
- **Toolbar button** (YouTube icon) → opens a URL input dropdown for manual embeds

## Action Text sanitizer

If you use Action Text to store the editor output, whitelist the `<iframe>` and `<figure>` tags so embeds survive the sanitizer:

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

## License

MIT

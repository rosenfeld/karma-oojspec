# OOJSpec framework adapter for Karma

This plugin will only work when used with Karma from master since it relies on custom context
files. Also, even in master it seems the plugin changes to the relevant config options do not
take effect, so you'll have to add this to your config:

```javascript
{
  config.customContextFile: 'node_modules/karma-oojspec/static/context.html'
  config.customDebugFile: 'node_modules/karma-oojspec/static/debug.html'

  // other relevant entries to oojspec:
  frameworks: ['oojspec']
  plugins: ['karma-oojspec']
}
```

## Usage

    npm install karma-oojspec --save-dev

Add `frameworks: ['oojspec']` to the Karma configuration and add 'karma-oojspec' to the `plugins`
array.

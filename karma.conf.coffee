module.exports = (config)->
  config.set
    frameworks: ['jasmine']

    files: [
      'bower_components/jquery/dist/jquery.js'
      'tmp/spec/**/*.js'
    ]
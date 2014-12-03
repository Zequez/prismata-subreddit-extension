module.exports = (config)->
  config.set
    frameworks: ['jasmine']

    files: [
      'bower_components/jquery/dist/jquery.js'
      '_build_test/**/*.js'
    ]
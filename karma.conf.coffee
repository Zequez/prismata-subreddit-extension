module.exports = (config)->
  config.set
    frameworks: ['jasmine']

    files: [
      'bower_components/jquery/dist/jquery.js'
      '_build_test/**/*.js'
    ]

    browsers: ['Chrome_without_security']

    customLaunchers:
      Chrome_without_security:
        base: 'Chrome'
        flags: ['--disable-web-security']
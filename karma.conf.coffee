module.exports = (config)->
  config.set
    frameworks: ['jasmine-ajax', 'jasmine']

    files: [
      'bower_components/jquery/dist/jquery.js'
      '_build_test/**/*.js'
      {pattern: '_build_test/**/*.html', included: false}
      {pattern: '_build_test/**/*.json', included: false}
    ]

    # browsers: ['Chrome_without_security']

    # customLaunchers:
    #   Chrome_without_security:
    #     base: 'Chrome'
    #     flags: ['--disable-web-security']
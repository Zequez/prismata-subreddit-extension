_           = require 'lodash-node'
gulp        = require 'gulp'
gutil       = require 'gulp-util'
coffee      = require 'gulp-coffee'
concat      = require 'gulp-concat'
karma       = require('karma').server
zip         = require 'gulp-zip'
sourcemaps  = require 'gulp-sourcemaps'
merge       = require 'merge-stream'
uglify      = require 'gulp-uglify'
gulpFilter  = require 'gulp-filter'

filters = null
resetFilters = ->
  filters =
    js:       gulpFilter('**/*.js')
    coffee:   gulpFilter('**/*.coffee')
    noScript: gulpFilter(['**/*', '!**/*.coffee', '!**/*.js', '!**/*.psd'])
resetFilters()

sources =
  watch: ['./src/**/*.coffee', './spec/**/*.coffee']
  watch_static: ['./src/**/*', './data/**/*', '!*.coffee']

  src: './src/**/*'
  spec: './spec/**/*'
  dev: './_build_dev/**/*'
  prod: './_build_prod/**/*'
  test: './_build_test/**/*'
  data: './data/**/*.json'

  srcBackgrounds: [
    # vendor scripts here
    './src/bg/preBackground.coffee'
    './src/bg/**/!(background|preBackground)*.coffee'
    './src/bg/background.coffee'
  ]

  srcInjects: [
    # vendor scripts here
    './src/inject/preInject.coffee'
    './src/inject/**/!(inject|preInject)*.coffee'
    './src/inject/inject.coffee'
  ]

  srcTests: [
    './data/**/*.json'
    './spec/fixtures/**.*'
    './spec/spec_helper.coffee'
    './spec/**/!(spec_helper)*.coffee'
  ]


sources.srcTests = sources
  .srcBackgrounds[0...-1]
  .concat(sources.srcInjects[0...-1])
  .concat(sources.srcTests)

destinations =
  dev: './_build_dev/'
  prod: './_build_prod/'
  test: './_build_test'

  backgroundName: 'bg/background.js'
  injectName: 'inject/inject.js'
  testName: 'background_inject_specs.js'

  zipPath: './'
  zipName: 'extension.zip'

# copy inject and background combined files to /build
gulp.task 'src_build', ->
  resetFilters()
  # content script
  gulp.src(sources.srcInjects)
    # .pipe(sourcemaps.init())
    .pipe(filters.coffee).pipe(coffee()).pipe(filters.coffee.restore())
    .pipe(concat(destinations.injectName))
    # .pipe(sourcemaps.write())
    .pipe(gulp.dest(destinations.dev))

  resetFilters()
  # background script
  gulp.src(sources.srcBackgrounds)
    # .pipe(sourcemaps.init())
    .pipe(filters.coffee).pipe(coffee()).pipe(filters.coffee.restore())
    .pipe(concat(destinations.backgroundName))
    # .pipe(sourcemaps.write())
    .pipe(gulp.dest(destinations.dev))

gulp.task 'src_build_static', ->
  # TODO: Read the data from package.json and add it to manifest.json
  # so I don't have to write the same data twice
  # Copy everything that is not an script
  resetFilters()
  gulp.src(sources.src)
    .pipe(filters.noScript)
    .pipe(gulp.dest(destinations.dev))

  # Copy the data/units.json file
  gulp.src(sources.data)
    .pipe(gulp.dest(destinations.dev))

gulp.task 'src_build_for_deployment', ->
  resetFilters()
  # Copy from dev to prod and UglifyJS
  gulp.src(sources.dev)
    .pipe(filters.js)
    .pipe(uglify())
    .pipe(filters.js.restore())
    .pipe(gulp.dest(destinations.prod))

# copy inject, background and specs combined files to /tmp
gulp.task 'src_build_for_test', ->
  resetFilters()
  gulp.src(sources.srcTests)
    # .pipe(sourcemaps.init())
    .pipe(filters.coffee).pipe(coffee()).pipe(filters.coffee.restore())
    .pipe(filters.js).pipe(concat(destinations.testName)).pipe(filters.js.restore())
    # .pipe(sourcemaps.write())
    .pipe(gulp.dest(destinations.test))

# karma doesn't like gulp watching, so she has to watch herself
gulp.task 'karma_watch', (done)->
  karma.start
    configFile: __dirname + '/karma.conf.coffee'
  , done

# watch /src folder for src build, spec build and copying
gulp.task 'watch', ->
  gulp.watch sources.watch, ['src_build', 'src_build_for_test']
  gulp.watch sources.watch_static, ['src_build_static']

# create a zip from the /prod_build folder
gulp.task 'build_zip', ->
  # TODO: Rename it to something like 'name-of-the-extension-0.1.0.zip'
  gulp.src(sources.prod)
    .pipe(zip(destinations.zipName))
    .pipe(gulp.dest(destinations.zipPath))

gulp.task 'default', [
  'watch'
  'karma_watch'
  'src_build'
  'src_build_static'
  'src_build_for_test'
]

gulp.task 'build', [
  'src_build'
  'src_build_for_deployment'
  'build_zip'
]
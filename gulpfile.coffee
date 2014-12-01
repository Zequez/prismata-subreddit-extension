gulp =    require 'gulp'
gutil =   require 'gulp-util'
coffee =  require 'gulp-coffee'
concat =  require 'gulp-concat'
karma =   require 'gulp-karma'
zip =     require 'gulp-zip'

sources =
  watch: ['./src/**/*.coffee', './spec/**/*.coffee']
  backgrounds: [
    './src/bg/**/!(run)*.coffee'
    './src/bg/run.coffee'
  ]
  
  injects: [
    './src/inject/**/!(run)*.coffee'
    './src/inject/run.coffee'
  ]

  tests: [
    './src/**/!(run)*.coffee'
    './spec/spec_helper.coffee'
    './spec/**/!(spec_helper)*.coffee'
  ]

  copy: [
    './src/*'
    './src/icons/*'
  ]
  copyBase: './src'

  zip: [
    './build/**/*'
  ]

  specRunner: './spec/spec_runner.html'

destinations =
  backgroundPath: './build/bg/'
  backgroundName: 'background.js'

  injectPath: './build/inject/'
  injectName: 'inject.js'

  testPath: './tmp/spec/'
  testName: 'background_inject_specs.js'

  copyPath: './build/'

  zipPath: './'
  zipName: 'extension.zip'

# copy inject and background combined files to /build
gulp.task 'src_build', ->
  gulp.src(sources.injects)
    # We concat first so we don't need to clutter
    # the global space with global variables
    .pipe(concat(destinations.injectName))
    .pipe(coffee())
    .pipe(gulp.dest(destinations.injectPath))

  gulp.src(sources.backgrounds)
    .pipe(concat(destinations.backgroundName))
    .pipe(coffee())
    .pipe(gulp.dest(destinations.backgroundPath))

# copy the rest of the files to /build
gulp.task 'src_copy', ->
  # TODO: Read the data from package.json and add it to manifest.json
  # so I don't have to write the same data twice
  gulp.src(sources.copy, base: sources.copyBase)
    .pipe(gulp.dest(destinations.copyPath))

# copy inject, background and specs combined files to /tmp
gulp.task 'spec_build', ->
  gulp.src(sources.tests)
    .pipe(concat(destinations.testName))
    .pipe(coffee())
    .pipe(gulp.dest(destinations.testPath))

# karma doesn't like gulp watching, so she has to watch herself
gulp.task 'karma_watch', ->
  gulp.src(destinations.testPath + destinations.testName)
    .pipe(karma(
      configFile: 'karma.conf.coffee'
      action: 'watch'
    ))

# watch /src folder for src build, spec build and copying
gulp.task 'watch', ->
  gulp.watch sources.watch, ['src_build', 'spec_build']
  gulp.watch sources.copy, ['src_copy']

# create a zip from the /build folder
gulp.task 'build_zip', ->
  # TODO: Rename it to something like 'name-of-the-extension-0.1.0.zip'
  gulp.src(sources.zip)
    .pipe(zip(destinations.zipName))
    .pipe(gulp.dest(destinations.zipPath))


gulp.task 'default', [
  'watch'
  'karma_watch'
  'src_copy'
  'src_build'
]

gulp.task 'build', [
  'src_copy'
  'src_build'
  'build_zip'
]
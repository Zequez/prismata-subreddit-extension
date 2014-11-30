gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'

sources =
  watch: './src/**'
  backgrounds: [
    './src/bg/**/!(run)*.coffee'
    './src/bg/run.coffee'
  ]
  
  injects: [
    './src/inject/**/!(run)*.coffee'
    './src/inject/run.coffee'
  ]
destinations =
  background: './src/bg/'
  inject: './src/inject/'
  concat: 'all.js'

gulp.task 'coffee', ->
  gulp.src(sources.injects)
    .pipe(concat(destinations.concat)) # We concat first so we don't clutter the global space having to declare any global variable
    .pipe(coffee())
    .pipe(gulp.dest(destinations.inject))

  gulp.src(sources.backgrounds)
    .pipe(concat(destinations.concat))
    .pipe(coffee())
    .pipe(gulp.dest(destinations.background))


gulp.task "watch", ->
  gulp.watch sources.watch, ["coffee"]

gulp.task "default", [
  "watch"
]
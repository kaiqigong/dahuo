# Main application routes

'use strict'

errors = require('./components/errors')
errorHandler = (err, req, res, next)->
  # logger.error err
  console.dir(next)
  res.json(err.status or 500, err)

module.exports = (app) ->

  # Insert routes below
  app.use('/api/eateries', require('./api/eatery'))
  app.use('/api/dishes', require('./api/dish'))
  app.use('/api/users', require('./api/user'))

  app.use('/auth', require('./auth'))
  app.use(errorHandler)
  # All undefined asset or api routes should return a 404
  app.route('/:url(api|auth|components|app|bower_components|assets)/*')
   .get(errors[404])

  # All other routes should redirect to the index.html
  app.route('/*')
    .get((req, res) ->
      res.sendfile(app.get('appPath') + '/index.html')
    )

###
  Main application file
###

'use strict'

# Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV or 'development'

express = require('express')
mongoose = require('mongoose')
config = require('./config/environment')
cors = require('cors')

# Connect to database
mongoose.connect(config.mongo.uri, config.mongo.options)

# Populate DB with sample data
# if(config.seedDB) { require('./config/seed') }
# Run coffee server/config/seed.coffee
# ctrl + c

# Setup server
app = express()
app.use(cors())
server = require('http').createServer(app)
socketio = require('socket.io').listen(server)
require('./config/socketio')(socketio)
require('./config/express')(app)
require('./routes')(app)

# Start server
server.listen config.port, config.ip, ->
  console.log 'Express server listening on %d, in %s mode', config.port, app.get('env')

# Expose app
exports = module.exports = app

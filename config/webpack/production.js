const environment = require('./environment')
const customConfig = require('./config')

module.exports = module.exports = {
  ...environment.toWebpackConfig(),
  ...customConfig
}

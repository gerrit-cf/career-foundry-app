const environment = require('./environment')
const customConfig = require('./custom')

module.exports = module.exports = {
  ...environment.toWebpackConfig(),
  ...customConfig
}

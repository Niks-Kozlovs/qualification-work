import config from '../knexfile.js';
var env         = 'development';
var knex        = require('knex')(config[env]);

export default knex;

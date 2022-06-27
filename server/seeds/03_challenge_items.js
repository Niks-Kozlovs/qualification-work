var faker = require('faker');

exports.seed = function(knex) {
  // Deletes ALL existing entries
  function getChallengeName(requirement, type_id) {
    const types = [
      "in a single run",
      "in total",
      "in a time frame",
      "in a single run time frame",
    ]

    const names = [
      `Run over a ${Math.floor(requirement / 1000) || 1}km ${types[type_id - 1]}`,
      `Run ${Math.floor(requirement / 1000) || 1}km ${types[type_id - 1]}`
    ]

    return names[faker.random.number(1)];
  }

  return knex('challenge_items').del()
    .then(function () {
      // Inserts seed entries

      const challengeItems = Array.apply(null, Array(30 * 3)).map((item,index) => {
        const requirement = (faker.random.number(49) + 1) * 1000;
        const type_id = faker.random.number(2) + 1;

        return {
        challenge_id: faker.random.number(29) + 1,
        name: getChallengeName(requirement, type_id),
        type_id,
        requirements: requirement
      }});
      return knex('challenge_items').insert(challengeItems);
    });
};

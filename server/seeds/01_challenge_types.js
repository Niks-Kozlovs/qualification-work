
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('challenge_types').del()
    .then(function () {
      // Inserts seed entries
      return knex('challenge_types').insert([
        {id: 1, name: "SINGLE"},
        {id: 2, name: "TOTAL"},
        {id: 3, name: "TIMED"},
        {id: 4, name: "SINGLE_TIMED"},
      ]);
    });
};

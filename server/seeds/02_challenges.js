exports.seed = function(knex) {

  function addDays(date, days) {
    var result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
  }
  // Deletes ALL existing entries
  return knex('challenge_events').del()
    .then(function () {
      // Inserts seed entries

      const date = Date.now();

      const challenges = Array.apply(null, Array(30)).map((item,index) => ({
        startDate: addDays(date, 15 * index),
        endDate: addDays(date, index * 15 + 15)
      }));

      return knex('challenge_events').insert(challenges);
    });
};

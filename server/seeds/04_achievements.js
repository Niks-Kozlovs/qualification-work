
exports.seed = function(knex) {
  // Deletes ALL existing entries
  return knex('achievements').del()
    .then(function () {
      // Inserts seed entries

      const totalRunAchievements = Array.apply(null, Array(10)).map((item,index) => ({
        name: `Run a total of ${(index + 1) * 5}km`,
        type_id: 2,
        requirements: (index + 1) * 5000
      }));

      const singleRunAchievements = Array.apply(null, Array(10)).map((item,index) => ({
        name: `Run ${(index + 1) * 5}km`,
        type_id: 1,
        requirements: (index + 1) * 5000
      }));

      return knex('achievements').insert([...totalRunAchievements, ...singleRunAchievements]);
    });
};

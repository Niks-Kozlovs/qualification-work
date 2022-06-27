import knex from '../../../db';

async function getAchievement(id) {
    return await knex('achievements')
    .join('challenge_types', { 'achievements.type_id': 'challenge_types.id' })
    .select('achievements.*', 'challenge_types.name as type')
    .where({'achievements.id': id})
    .then(achievements => achievements[0]);
}

async function getAllAchievements () {
    return await knex('achievements')
    .join('challenge_types', { 'achievements.type_id': 'challenge_types.id' })
    .select('achievements.*', 'challenge_types.name as type')
    .then(achievemnts => achievemnts)
}

async function getAllAchievementTypes() {
    return await knex('challenge_types')
    .select('*')
    .then(achievementTypes => achievementTypes);
}

async function getAchievementType(id) {
    return await knex('challenge_types')
    .select('*')
    .where({id})
    .then(achievementTypes => achievementTypes[0]);
}

async function getUserAchievement(id, userId) {
    if (!userId) {
        throw new Error('User not authenticated');
    }

    return await knex('user_achievements')
    .select('*')
    .where({user_id: userId, achievement_id: id})
    .then(userAchievements => userAchievements[0]);
}

async function getAllUserAchievements(userId) {
    if (!userId) {
        throw new Error('User not authenticated');
    }

    return await knex('user_achievements')
    .select('*', 'complete as isComplete')
    .where({user_id: userId})
    .then(userAchievements => userAchievements);
}

export {
    getAchievement,
    getAllAchievements,
    getAchievementType,
    getAllAchievementTypes,
    getUserAchievement,
    getAllUserAchievements
};

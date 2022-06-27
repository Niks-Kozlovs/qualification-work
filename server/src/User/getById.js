import knex from '../db';
import { getAllUserRoutes } from '../resolvers/Route/queries';

export default async function getById(id) {
    return knex('user').first().where({ID: id}).then(async result => {

        const [
            [challenges],
            [achievements],
            allItems,
            boughtItems,
            equippedItems,
            allUserRuns,
            [userFriends],
            [friendRequests]
        ] = await Promise.all([
                getUserChallenges(id),
                getUserAchievements(id),
                getAllItems(),
                getBoughtItems(id),
                getEquippedItems(id),
                getAllUserRoutes(id),
                getUserFriends(id),
                getUserFriendRequests(id)
        ]);

        return {
        ...result,
        challenges,
        inventory: allItems,
        boughtItems: boughtItems,
        equippedItems: equippedItems,
        achievements,
        runs: allUserRuns,
        friends: userFriends,
        friendRequests,
        }
    });
}

async function getUserFriends(id) {
    return knex('user_friend')
    .select()
    .join('user', {'user.ID': 'user_friend.friend_id'})
    .where({'user.ID': id})
    .then(result => result);
}

async function getUserFriendRequests(id) {
    return knex('user_friend')
    .select()
    .where({user_id: id, status: 'PENDING'})
    .then(result => result);
}

async function getBoughtItems(id) {
    return knex('user_bought_item')
    .select('item_id')
    .where({user_id: id})
    .then(result => result.map(item => item.item_id));
}

async function getEquippedItems(id) {
    return knex('user_equipped_item')
    .select('item_id')
    .where({user_id: id})
    .then(result => result.map(item => item.item_id));
}

async function getAllItems() {
    return knex('item')
    .select()
    .then(items => items);
}

async function getUserChallenges(id) {
    const latestChallengeId = await getCurrentChallenge();

    //TODO: Fix the DRY principle
    return knex.raw(`SELECT * from (SELECT * from task where task.type = 'CHALLENGE') as task left join user_task on user_task.task_id = task.ID inner join challenge_task on (challenge_task.task_id = task.ID AND challenge_task.challenge_id = ${latestChallengeId.ID} ) where user_task.user_id = '${id}' OR user_id IS NULL;`)
    .then(result => result);
}

async function getCurrentChallenge() {
    return await knex('challenge')
    .first()
    .orderBy('end_date')
    .whereRaw('end_date > CURDATE()')
    .then(result => result);
}

async function getUserAchievements(id) {
    return knex.raw(`SELECT * from (SELECT * from task where task.type = 'ACHIEVEMENT') as task left join user_task on user_task.task_id = task.ID where user_task.user_id = '${id}' OR user_id IS NULL;`).then(result => result);
}

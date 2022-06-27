import knex from '../../../db';

async function addChallengeItems(challenges) {
    const result = challenges.map(async challenge => {
        const result = await getChallengeItems(challenge.id || challenge.challenge_item_id);

        const challenges = result.map(item => ({
            itemId: item.id,
            ...item
        }))

        return {
            challengeId: challenge.id,
            ...challenge,
            challenges
        }
    });

    return await Promise.all(result);
}

async function getChallengeItems(challenge_id) {
    return await knex('challenge_items')
    .select('challenge_items.*', 'challenge_types.name as type')
    .where({'challenge_items.challenge_id': challenge_id})
    .join('challenge_types', {'challenge_items.type_id': 'challenge_types.id'})
    .then(challengeItems => challengeItems);
}

async function getChallengeItem(item_id) {
    return await knex('challenge_items')
    .select('challenge_items.*', 'challenge_types.name as type')
    .where({'challenge_items.id': item_id})
    .join('challenge_types', {'challenge_items.type_id': 'challenge_types.id'})
    .first()
    .then(challengeItem => challengeItem);
}

async function getAllChallenges() {
    return await knex('challenge_events')
    .select('*')
    .then(async challenges => await addChallengeItems(challenges))
}



async function getChallenge(challenge_id) {
    return await knex('challenge_events')
    .select('*')
    .where({id: challenge_id})
    .then(async (challenges) => {
        const result = await addChallengeItems(challenges);
        return result[0];
    });
}

async function getLatestChallenge() {
    return await knex('challenge_events')
    .select('*')
    .orderBy('startDate')
    .first()
    .then(async (challenges) => {
        const result = await addChallengeItems([challenges]);
        return result[0];
    })
}

async function getUserChallenge(challenge_id, userId) {
    return await knex('user_challenges')
    .select('*')
    .where({user_id: userId, challenge_item_id: challenge_id})
    .then(async (challenges) => {
        const result = await addChallengeItems(challenges);
        return result[0];
    })
}

async function getUserChallenges(userId) {
    return await knex('user_challenges')
    .select('*')
    .where({user_id: userId})
    .then(async (challenges) => {
        return await Promise.all(challenges.map(async (challenge) => ({
                ...challenge,
                challengeItem: await getChallengeItem(challenge.challenge_item_id)
            })));
    });
}

export {
    getAllChallenges,
    getChallenge,
    getLatestChallenge,
    getUserChallenges,
    getUserChallenge,
}
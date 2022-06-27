import knex from '../../../db';
import { getUserRoute } from '../queries';

async function finishRun(userId, params) {
    //TODO: Get a better experience and coins algorithm
    //TODO: Check if any challagnes or achievements have gotten completed from this run (also update the typedefs file then)
    const experience = params.distance;
    const coins = params.distance;

    return knex('run')
    .insert({
        user_id: userId,
        rating: params.rating,
        experience,
        coins
    })
    .then(async runId => {
        await Promise.all([
            insertLocationData(runId, params),
            updateUserProfile(userId, experience, coins),
        ]);

        return await getUserRoute(runId, userId);
    })
}

async function insertLocationData(runId, params) {
    return await knex('user_run_data')
    .insert(params.locations.map(location => ({run_id: runId, ...location})))
    .then()
}

async function updateUserProfile(userId, experience, coins) {
    return await knex('user')
    .where({id: userId})
    .update({
        updated_at: new Date(),
        coins: knex.raw(`coins + ${coins}`),
        experience: knex.raw(`experience + ${experience}`)
    })
    .then();
}

export { finishRun }
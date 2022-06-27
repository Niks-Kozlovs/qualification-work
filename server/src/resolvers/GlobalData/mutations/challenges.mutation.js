import knex from '../../../db';
import { getChallenge } from '../queries';

function formatChallengeItems(items, challenge_id) {
    return items.map(item => ({
        challenge_id,
        name: item.name,
        type_id: item.typeId,
        requirements: item.requirements
    }));
}

async function addToChallenge(params) {
    const challengeItems = formatChallengeItems(params.challenges, params.challengeId);

    return await knex('challenge_items')
    .insert(challengeItems)
    .then(() => true);
}

async function addChallenge(params) {
    return await knex('challenge_events')
    .insert({
        startDate: params.startDate,
        endDate: params.endDate
    })
    .then(async ([challengeId]) => {
        await addToChallenge({challenges: params.challenges, challengeId});
        return await getChallenge(challengeId);
    });
}

export {
    addToChallenge,
    addChallenge,
}
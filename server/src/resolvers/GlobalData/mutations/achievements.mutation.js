import knex from '../../../db';
import { getAchievementType, getAchievement } from '../queries';

async function addAchievement(params) {
    return await knex('achievements')
    .insert({
        name: params.name,
        type_id: params.typeId,
        requirements: params.requirements
    })
    .then(async id => await getAchievement(id));
}

async function addAchievementType(params) {
    return await knex('challenge_types').insert({
        name: params.typeName
    })
    .then(async id => await getAchievementType(id));
}

export {
    addAchievement,
    addAchievementType,
};

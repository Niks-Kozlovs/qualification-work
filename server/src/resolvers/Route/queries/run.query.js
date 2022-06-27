import knex from '../../../db';

async function getLocationData(routeId) {
    return await knex('user_run_data')
    .select()
    .where({run_id: routeId})
    .then(locaitonData => locaitonData);
}

async function getUserRoute(id, userId) {
    return await knex('run')
    .first()
    .where({id, user_id: userId})
    .then(async route => {
        const routeData = await getLocationData(route.ID)

        return {
            ...route,
            locationData: routeData
        }
    });
}

async function getAllUserRoutes(userId) {
    return await knex('run')
    .select()
    .where({user_id: userId})
    .orderBy('ID', "desc")
    .then(async routes => {
        return await Promise.all(routes.map(async route => {
            const routeData = await getLocationData(route.ID)
            return {
                ...route,
                locationData: routeData
            }
        }))
    })
}

export {
    getUserRoute,
    getAllUserRoutes
}
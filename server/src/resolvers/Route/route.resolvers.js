import {
    getUserRoute,
    getAllUserRoutes
} from './queries';

import {
    finishRun
} from './mutations'

export default {
    Mutation: {
        finishRun: async (_, params, { jwt: { userId } }) => await finishRun(userId, params)
    },
    Query: {
        userRoute: async (_, { id }, { jwt: { userId } }) => await getUserRoute(id, userId),
        allUserRoutes: async (_, __, { jwt: { userId } }) => await getAllUserRoutes(userId)
    }
};
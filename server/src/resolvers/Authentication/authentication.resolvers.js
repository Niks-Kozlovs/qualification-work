import {
    loginMutation,
    googleLoginMutation,
    registerMutation
} from './mutations';

import {
    getUserDataById
} from '../../User';

export default {
    Mutation: {
        login: async (_, { email, password }) => await loginMutation(email, password),
        googleLogin: async (_, { email, name }, { jwt: { userId } }) => await googleLoginMutation(email, name, userId),
        register: async (_, { name, email, password }) => await registerMutation(name, email, password)
    },
    Query: {
        me: async (_, __, { jwt: { userId } }) => await getUserDataById(userId),
    }
};

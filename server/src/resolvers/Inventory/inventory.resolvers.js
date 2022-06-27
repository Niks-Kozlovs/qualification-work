import {
    getUserEquippedItems,
    getUserBoughtItems,
    getAllItems,
    getItem,
} from './queries';

import {
    buyItem,
    equipItem,
    addItem,
    unequipItem,
} from './mutations';

export default {
    Mutation: {
        buyItem: async (_, params, { jwt: { userId } }) => await buyItem(userId, params),
        equipItem: async (_, params, { jwt: { userId } }) => await equipItem(userId, params),
        addItem: async(_, params) => await addItem(params),
        unequipItem: async (_, params, { jwt: { userId } }) => await unequipItem(userId, params),
    },
    Query: {
        userEquippedItems: async (_, __, { jwt: { userId } }) => await getUserEquippedItems(userId),
        userBoughtItems: async (_, __, { jwt: { userId } }) => await getUserBoughtItems(userId),
        allItems: async () => await getAllItems(),
        item: async (_, { id }) => await getItem(id),
    }
};
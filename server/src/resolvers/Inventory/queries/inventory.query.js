import knex from '../../../db';

async function getUserEquippedItems(userId) {
    return await knex('user_equipped_item')
    .select('*')
    .where({user_id: userId})
    .then(async items => {
        return await Promise.all(items.map(item => getItem(item.item_id)));
    });
}

async function getUserBoughtItems(userId) {
    return await knex('user_bought_item')
    .select('*')
    .where({user_id: userId})
    .then(async items => {
        return await Promise.all(items.map(item => getItem(item.item_id)));
    });
}

async function getAllItems() {
    return await knex('item')
    .select('*')
    .then(items => items);
}

async function getItem(id) {
    return await knex('item')
    .select('*')
    .where({id})
    .first()
    .then(item => item);
}

export {
    getUserEquippedItems,
    getUserBoughtItems,
    getAllItems,
    getItem
};

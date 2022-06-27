import knex from '../../../db';
import { getItem, getUserEquippedItems } from '../queries';
import { getUserDataById } from '../../../User';

async function buyItem(userId, params) {
    //TODO: Check if item has already been bought

    const item = await getItem(params.itemId);
    const user = await getUserDataById(userId);

    if (item.price > user.coins) {
        throw new Error('Not enought coins');
    }

    if (item.level > user.experience) {
        throw new Error('Not enough levels');
    }

    return await knex('user_bought_item')
    .insert({
        user_id: userId,
        item_id: params.itemId
    })
    .then(async () => {
        await knex('user')
        .update({
            updated_at: new Date(),
            coins: knex.raw(`coins - ${item.price}`),
        })
        .then();
        return item;
    });
}

async function equipItem(userId, params) {
    const [currEquippedItems, newItem] = await Promise.all([getUserEquippedItems(userId), getItem(params.itemId)]);

    if (!newItem) {
        throw new Error('No item found!');
    }

    //TODO: Check if user has bought this item

    const equippedType = currEquippedItems.find(item => item.type === newItem.type);
    if (!equippedType) {
        return await knex('user_equipped_item')
        .insert({
            item_id: params.itemId,
            user_id: userId
        })
        .then(() => true)
    }

    return await knex('user_equipped_item')
    .where({
        item_id: equippedType.ID,
        user_id: userId
    })
    .update({
        item_id: params.itemId
    })
    .then(result => {
        return true;
    });
}

async function unequipItem(userId, params) {
    return await knex('user_equipped_item')
    .where({user_id: userId, item_id: params.itemId})
    .del()
    .then(() => true);
}

async function addItem(params) {
    return await knex('item')
    .insert({...params, cost: params.cost || 0, level: params.level || 0})
    .then(async itemId => await getItem(itemId));
}

export {
    buyItem,
    equipItem,
    addItem,
    unequipItem,
}
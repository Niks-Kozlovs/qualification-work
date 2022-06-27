import knex from '../../../db';
import uniqueString from 'unique-string';
import { sign } from 'jsonwebtoken';
import { getUserDataById } from '../../../User';
import bcrypt from 'bcrypt';

async function registerMutation (name, email, password) {
    const number = await knex('user').first('number').where({ username: name }).orderBy('number', 'desc').then(number => number);

    const userData = {
        id: uniqueString(),
        username: name,
        email,
        coins: 0,
        experience: 0,
        number: number ? number.number + 1 : 0,
    }

    await bcrypt.hash(password, 10, (err, hash) => {
        knex('user')
        .insert({...userData, password: hash})
        .then(result => result);
    });

    const token = sign({userId: userData.id}, process.env.SECRET_KEY);

    return {
        token,
        user: await getUserDataById(userData.id)
    }
}

export {
    registerMutation
}
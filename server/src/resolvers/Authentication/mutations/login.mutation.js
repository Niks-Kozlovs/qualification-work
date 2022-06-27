import knex from '../../../db';
import bcrypt from 'bcrypt';
import { sign } from 'jsonwebtoken';
import { getUserDataById } from '../../../User';

async function loginMutation(email, password) {
    return knex('user')
    .select('*')
    .where({email})
    .first()
    .then(async user => {
        if (!user) {
            return null;
        }

        const result = await bcrypt.compare(password, user.password);

        if (!result) {
            return null;
        }

        const token = sign({userId: user.ID}, process.env.SECRET_KEY);

        return {
            token,
            user: await getUserDataById(user.ID)
        }
    })
};

async function googleLoginMutation(email, name, googleId) {
    try {
        const user = await getUserDataById(googleId);
        const token = sign({userId: user.id}, process.env.SECRET_KEY);

        return {
            token,
            user
        }
    } catch (error) {
        console.error(error);
    }

    if (!name || !email) {
        throw new Error('Query must have name and email')
    }

    const userData = {
        id: googleId,
        name,
        email,
        coins: 0,
        experience: 0,
    }

    return knex('user')
    .insert(userData)
    .then(async () => {
        const token = sign({userId: googleId}, process.env.SECRET_KEY);

        return {
            token,
            user: await getUserDataById(googleId)
        }
    });

}

export {
    loginMutation,
    googleLoginMutation,
}

export const UPDATE_USER_INFO = 'UPDATE_USER_INFO';
export const CLEAR_USER_INFO = 'CLEAR_USER_INFO';

const updateInfo = (user) => ({
    type: UPDATE_USER_INFO,
    user
});

const clearUserInfo = () => ({
    type: CLEAR_USER_INFO
});

export {
    updateInfo,
    clearUserInfo,
};

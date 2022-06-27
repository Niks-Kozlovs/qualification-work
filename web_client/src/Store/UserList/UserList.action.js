export const UPDATE_USER_LIST_INFO = 'UPDATE_USER_LIST_INFO';

const updateInfo = (user) => ({
    type: UPDATE_USER_LIST_INFO,
    user
});

export {
    updateInfo,
};

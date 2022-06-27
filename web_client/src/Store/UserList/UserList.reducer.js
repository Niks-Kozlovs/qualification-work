import {
    UPDATE_USER_LIST_INFO,
} from './UserList.action';

const updateInfo = (action) => {
    return action;
};

const initialState = {
    users: []
};

const UserListReducer = (state = initialState, action) => {
    const { type } = action;

    switch (type) {
    case UPDATE_USER_LIST_INFO:
        return {
            ...state,
            ...updateInfo(action.user)
        };

    default:
        return state;
    }
};

export default UserListReducer;

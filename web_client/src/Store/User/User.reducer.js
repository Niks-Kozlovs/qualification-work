import {
    UPDATE_USER_INFO,
    CLEAR_USER_INFO,
} from './User.action';

const updateInfo = (action) => {
    return action;
};

const initialState = {
    user: { }
};

const UserReducer = (state = initialState, action) => {
    const { type } = action;

    switch (type) {
    case UPDATE_USER_INFO:
        return {
            ...state,
            ...updateInfo(action.user)
        };
    case CLEAR_USER_INFO:
        return initialState;

    default:
        return state;
    }
};

export default UserReducer;

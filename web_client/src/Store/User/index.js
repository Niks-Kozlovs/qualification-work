import UserReducer from './User.reducer';
import UserDispatcher from './User.dispatcher';

import {
    UPDATE_USER_INFO,
    CLEAR_USER_INFO,
    clearUserInfo,
    updateInfo,
} from './User.action';

export {
    UserReducer,
    UserDispatcher,
    UPDATE_USER_INFO,
    CLEAR_USER_INFO,
    updateInfo,
    clearUserInfo,
};

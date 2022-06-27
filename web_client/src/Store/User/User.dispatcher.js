import {
    updateInfo,
    clearUserInfo,
} from 'Store/User';

class UserDispatcher {
    updateUserInfo(dispatch, data) {
        dispatch(updateInfo(data));
    }
    clearUserInfo(dispatch) {
        dispatch(clearUserInfo())
    }
}

export default new UserDispatcher();

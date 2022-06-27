import {
    updateInfo,
} from 'Store/UserList';

class UserListDispatcher {
    updateUserInfo(dispatch, data) {
        dispatch(updateInfo(data));
    }
}

export default new UserListDispatcher();

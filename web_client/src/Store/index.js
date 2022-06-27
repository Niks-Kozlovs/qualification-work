import {
    createStore, combineReducers
} from 'redux';

import { UserReducer } from 'Store/User';
import { UserListReducer } from 'Store/UserList';

const reducers = {
    UserReducer,
    UserListReducer,
};

const store = createStore(
    combineReducers(reducers),
    ( // enable Redux dev-tools only in development
        process.env.NODE_ENV === 'development'
        && window.__REDUX_DEVTOOLS_EXTENSION__
    ) && window.__REDUX_DEVTOOLS_EXTENSION__({
        trace: true
    })
);

export default store;

export { reducers };

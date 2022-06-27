import React from 'react';
import { Router, Switch, Route } from 'react-router-dom';
import { createBrowserHistory } from 'history';
import {
    HomePage,
    SharedRoute,
    AdminLogin,
    AdminPanel,
} from './Routes';
import { Provider } from 'react-redux';
import store from 'Store';

import './style/main.scss';

export const history = createBrowserHistory({ basename: '/' });


function App() {
    return (
        <Provider store={ store }>
            <Router history={ history }>
                <Switch>
                    <Route exact path="/" component={ HomePage } />
                    <Route exact path="/shared/route/:routeId" component={ SharedRoute } />
                    <Route exact path="/admin" component={ AdminLogin } />
                    <Route exact path="/admin/panel" component={ AdminPanel } />
                </Switch>
            </Router>
        </Provider>
    );
}

export default App;

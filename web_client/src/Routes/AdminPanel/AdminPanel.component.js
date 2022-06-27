import React, { Component } from 'react';
import './AdminPanel.style.scss';
import UserView from 'Components/AdminPanelViews/UserView';

const ITEMS = 'ITEMS';
const SHARED_ROUTES = 'SHARED_ROUTES';

class AdminPanel extends Component {
    constructor(props) {
        super(props);
        this.state = {view: <UserView />};
    }

    setView(view) {
        this.setState({
            view
        });
    }

    render() {
        return (
            <div>
                <nav className="NavBar">
                    <button onClick={ () => this.setView(<UserView />) }>Users</button>
                    <button onClick={ () => this.setView(ITEMS) }>Items</button>
                    <button onClick={ () => this.setView(SHARED_ROUTES) }>Shared Routes</button>
                    <div className="AlignRight">
                        <p>{this.props.userData.user.username}</p>
                        <button onClick={ () => this.props.logout() }>Log out</button>
                    </div>
                </nav>

                <div>{ this.state.view }</div>
            </div>
        );
    }
}

export default AdminPanel;

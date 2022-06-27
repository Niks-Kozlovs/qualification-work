import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import AdminPanel from './AdminPanel.component';
import { UserDispatcher } from 'Store/User';

const mapStateToProps = state => ({
    userData: state.UserReducer
});

const mapDispatchToProps = dispatch => ({
    logout: () => UserDispatcher.clearUserInfo(dispatch, {})
});

class AdminPanelContainer extends Component {
    render() {
        const { userData: { token }, history } = this.props;

        if (!token) {
            history.replace({pathname: '/admin'});
        }

        return (
            <AdminPanel
                {...this.props }
                {...this.state}
            />
        );
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(withRouter(AdminPanelContainer));

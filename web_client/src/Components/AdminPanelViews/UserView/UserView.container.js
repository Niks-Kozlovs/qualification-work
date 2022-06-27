import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import AdminLogin from './AdminLogin.component';
import { UserDispatcher } from 'Store/User';

const mapDispatchToProps = dispatch => ({
    setUserData: options => UserDispatcher.updateUserInfo(dispatch, options)
});

const mapStateToProps = state => ({
    user: state.UserReducer
});

class UserViewContainer extends Component {
    render() {
        const { user: { token }, history } = this.props;

        if (token) {
            history.replace({pathname: '/admin/panel'});
        }

        return (
            <AdminLogin
                {...this.props}
                {...this.state}
            />
        );
    }
}

export default connect(mapStateToProps, mapDispatchToProps)(withRouter(AdminLoginContainer));

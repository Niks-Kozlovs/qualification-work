import React, { Component } from 'react';
import './AdminLogin.style.scss';

class AdminLogin extends Component {
    constructor(props) {
        super(props);
        this.state = {email: '', password: '', isLoading: false};

        this.handleEmailChange = this.handleEmailChange.bind(this);
        this.handlePasswordChange = this.handlePasswordChange.bind(this);
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    setIsLoading(status) {
        this.setState({
            isLoading: status
        });
    }

    handleSubmit(event) {
        this.setIsLoading(true);
        const { setUserData, history } = this.props;
        const url = 'http://localhost:4000/';
        const mutation = JSON.stringify({
            query: `
            mutation {
                login(email: "${this.state.email}" password: "${this.state.password}") {
                  token
                  user {
                    username
                    role
                  }
                }
              }
    `
        });
        fetch(url, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: mutation
        })
            .then((res) => res.json())
            .then(({ data }) => {
                if (data.login.user.role !== "ADMIN") {
                    console.error('user is not admin');
                    return;
                }
                this.setIsLoading(false);
                setUserData(data.login);
                history.push({pathname: '/admin/panel'});
            });
        event.preventDefault();
    }

    handleEmailChange(event) {
        this.setState({email: event.target.value});
    }

    handlePasswordChange(event) {
        this.setState({password: event.target.value});
    }

    render() {
        return (
            <div className="LoginForm-Wrapper">
                <form onSubmit={this.handleSubmit} className="LoginForm">
                <label>
                    <p>Email:</p>
                    <input type="email" name="email" onChange={this.handleEmailChange} />
                </label>
                <label>
                    <p>Password:</p>
                    <input type="password" name="password" onChange={this.handlePasswordChange} />
                </label>
                <input type="submit" value="Submit" />
                </form>
            </div>
        );
    }
}

export default AdminLogin;

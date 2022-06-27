import React, { Component } from 'react';
import './HomePage.style.scss';

class HomePage extends Component {
    render() {
        return (
            <div className="HeroElement">
                <div className="CenterModal">
                    <p>Running made fun!</p>
                    <div className="Buttons">
                        <a href="www.google.com" style={ {"margin-right": "5px"} }>
                            <img src="https://lh3.googleusercontent.com/cjsqrWQKJQp9RFO7-hJ9AfpKzbUb_Y84vXfjlP0iRHBvladwAfXih984olktDhPnFqyZ0nu9A5jvFwOEQPXzv7hr3ce3QVsLN8kQ2Ao=s0" alt="Download on google play"/>
                        </a>
                        <a href="www.google.com">
                            <img src="/images/PlayStoreBadge.svg"  alt="Download on google play" />
                        </a>
                    </div>
                </div>
            </div>
        );
    }
}

export default HomePage;

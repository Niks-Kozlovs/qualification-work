import { GraphQLServer } from 'graphql-yoga';
import * as jwt from 'jsonwebtoken'
import typeDefs from './typeDefs';
import resolvers from './resolvers';

const makeContext = (req) => {
    const token = req.request.headers.authorization;
    if (!token) {
        return {}
    }
    const decoded = jwt.verify(
        token.replace('Bearer ', ''),
        process.env.SECRET_KEY
    );

    return {jwt: {...decoded}}
}

const server = new GraphQLServer({
    typeDefs,
    resolvers,
    context: req => ({...makeContext(req)})
});

server.start({
    port: process.env.PORT
}, () => console.log(`Server is running on localhost:${ process.env.PORT }`))
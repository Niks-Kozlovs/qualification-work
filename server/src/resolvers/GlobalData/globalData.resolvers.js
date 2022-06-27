import {
    getAchievement,
    getAllAchievements,
    getAchievementType,
    getAllAchievementTypes,
    getAllUserAchievements,
    getUserAchievement,
    getAllChallenges,
    getChallenge,
    getLatestChallenge,
    getUserChallenges,
    getUserChallenge,
} from './queries';

import {
    addAchievement,
    addAchievementType,
    addToChallenge,
    addChallenge,
} from './mutations';

export default {
    Mutation: {
        addAchievement: async (_, params) => await addAchievement(params),
        addAchievementType: async (_, params) => await addAchievementType(params),
        addToChallenge: async (_, params) => await addToChallenge(params),
        addChallenge: async (_, params) => await addChallenge(params),
    },
    Query: {
        achievement: async (_, { id }) => await getAchievement(id),
        allAchievements: async () => await getAllAchievements(),
        achievementType: async (_, { id }) => await getAchievementType(id),
        allAchievementTypes: async () => await getAllAchievementTypes(),
        allUserAchievements: async (_, __, { jwt: { userId } }) => await getAllUserAchievements(userId),
        userAchievement: async (_, { achievement_id }, { userId}) => await getUserAchievement(achievement_id, userId),
        allChallenges: async () => await getAllChallenges(),
        challenge: async (_, { challenge_id }) => await getChallenge(challenge_id),
        latestChallenge: async () => await getLatestChallenge(),
        allUserChallenges: async (_, __, { jwt: { userId } }) => await getUserChallenges(userId),
        userChallenge: async (_, { challenge_id }, { jwt: { userId } }) => await getUserChallenge(challenge_id, userId),
    }
};

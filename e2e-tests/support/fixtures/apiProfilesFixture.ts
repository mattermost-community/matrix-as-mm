import { test as base } from '@playwright/test';
import { UserAuthProfile } from '../models/userAuthProfile';

type MyFixtures = {
    matrix_connector: UserAuthProfile;
    mattermost_admin: UserAuthProfile;
    mattermost_bridge: UserAuthProfile;
    mattermost_user1: UserAuthProfile;
    matrix_admin: UserAuthProfile;
    matrix_bridge: UserAuthProfile;
    matrix_user1: UserAuthProfile;
};

export const test = base.extend<MyFixtures>({
    matrix_connector: ({}, use, info) => {
        let project: any = info.config?.projects[0];
        let profile: UserAuthProfile = project.use['matrix_connector'];
        use(profile);
    },
    mattermost_admin: ({}, use, info) => {
        let project: any = info.config?.projects[0];
        let profile: UserAuthProfile = project.use['mattermost_admin'];
        use(profile);
    },
    matrix_bridge: ({}, use, info) => {
        let project: any = info.config?.projects[0];
        let profile: UserAuthProfile = project.use['matrix_bridge'];
        use(profile);
    },
    mattermost_user1: ({}, use, info) => {
        let project: any = info.config?.projects[0];
        let profile: UserAuthProfile = project.use['mattermost_user1'];
        use(profile);
    },
    matrix_admin: ({}, use, info) => {
        let project: any = info.config?.projects[0];
        let profile: UserAuthProfile = project.use['matrix_admin'];
        use(profile);
    },
    mattermost_bridge: ({}, use, info) => {
        let project: any = info.config?.projects[0];
        let profile: UserAuthProfile = project.use['mattermost_bridge'];
        use(profile);
    },
    matrix_user1: ({}, use, info) => {
        let project: any = info.config?.projects[0];
        let profile: UserAuthProfile = project.use['matrix_user1'];
        use(profile);
    },
});

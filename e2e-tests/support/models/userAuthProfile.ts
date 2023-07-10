export interface UserAuthProfile {
    user: string;
    baseURL: string;
    password?: string;
    email?: string;
    asToken?: string;
    bearerToken?: string;
    domain?: string;
    additional?: any;
}

export interface UserAuthConfig {
    matrix_connector?: UserAuthProfile;
    mattermost_admin?: UserAuthProfile;
    mattermost_bridge?: UserAuthProfile;
    mattermost_user1?: UserAuthProfile;
    matrix_admin?: UserAuthProfile;
    matrix_bridge?: UserAuthProfile;
    matrix_user1?: UserAuthProfile;
}

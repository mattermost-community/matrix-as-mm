import { DataSource, DataSourceOptions } from 'typeorm';
import { User } from '../../entities/User';
import { Post } from '../../entities/Post';
import { Mapping } from '../../entities/Mapping';
//import Main from '../Main'

export const AppDataSource = new DataSource({
    type: 'postgres',
    host: 'localhost',
    port: 5432,
    username: 'mm-matrix-bridge',
    password: 'hunter2',
    database: 'mm-matrix-bridge',
   
    synchronize: true,
    logging: 'all',
    logger: 'advanced-console',
    entities: [Post, User,Mapping],
    subscribers: [],
    migrations: [],
});

export async function run(): Promise<any> {
    try {
        const ds = await AppDataSource.initialize();
        console.info(ds);
        let n = await User.count();
        console.log('Count users', n);
        const u = await User.findOne({
            where: { is_matrix_user: true },
        });
        console.log(u);
        /*
          let user = new User()
          user.access_token="x"
          user.is_matrix_user=false
          user.matrix_displayname="y"
          user.matrix_displayname="kalle"
          user.matrix_userid='xx'
          user.mattermost_userid='122'
          user.mattermost_username='Nils'
          user.save({"transaction":false})
          */
        n=await Mapping.count()
        console.log('Count Mappings', n);
        /*
        if(n === 0) {
            let m = new Mapping()
            m.mattermost_channel_id='1'
            m.matrix_room_id='2'
            await m.save()
        }
        */
    } catch (err) {
        console.error(err);
        throw err;
    }
}

run();

import {
    BaseEntity,
    Entity,
    PrimaryColumn,
    Column,
    DataSource

} from 'typeorm';

/**
 * An row in Post corresponds to an event/post that exists on both sides of the
 * bridge. There may be posts that only exist on one side of the bridge, e.g.
 * posts sent when the bridge is down, or messages that are only deleted on one
 * side, or messages sent by users the bridge skips. These will not be recorded
 * in the database.
 */
@Entity('posts')
export class Post extends BaseEntity {
    @PrimaryColumn('text', { nullable: false })
    public eventid!: string;

    @Column('character', { length: '26', nullable: false })
    public postid!: string;

    @Column('character', { length: '26', nullable: false })
    public rootid!: string;

    public static async removeAll(ds:DataSource, postid: string): Promise<void> {
        /*
        await getConnection().query(
            'DELETE FROM posts WHERE postid = $1 OR rootid = $1',
            [postid],
        );
        */
        await ds.createQueryBuilder()
    .delete()
    .from(Post)
    .where("postid = :postid or rootid = :rootid", { postid: postid, rootid:postid })
    .execute()
    }
}

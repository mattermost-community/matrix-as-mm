import { BaseEntity, Entity, PrimaryColumn, Column, Unique } from 'typeorm';

@Entity('mapping')
@Unique(['matrix_room_id'])
export class Mapping extends BaseEntity {
    @PrimaryColumn('text', { nullable: false })
    public mattermost_channel_id!: string;
    @Column('text', { nullable: false })
    public matrix_room_id!: string;
    @Column('boolean', { nullable: false, default: true })
    public is_private!: boolean;
    @Column('boolean', { nullable: false, default: true })
    public is_direct!: boolean;
    @Column('boolean', { nullable: false, default: true })
    public from_mattermost!: boolean;
    @Column('varchar', { length:255,nullable:true })
    public info!: string;
}

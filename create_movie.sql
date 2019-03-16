# MADE A NEW DATABASE FOR THESE QUERIES
# Query 9 
#drop table actor_role;
#drop table actors;
#drop table movies;
create table actors 
		( AID varchar(10) unique,
		Name varchar(20),
		primary key(AID)
		);

create table movies 
		(MID varchar(5)unique, 
		Title varchar(20),
		primary key (MID)
        );
create table actor_role
		(MID varchar(5),
        AID varchar (10),
        Rolename varchar(10),
        foreign key (MID) references movies(MID),
        foreign key (AID) references actors(AID)
        );
        
# Query 10
insert into actors values ('AC18MOV008', 'Charlie Chaplin');
insert into actors values ('AC18MOV002', 'Shah Rukh Khan');
insert into actors values ('BT16CSE012', 'Rinisha');
insert into actors values ('AC18MOV015', 'Leonardo DiCaprio');
insert into actors values ('AC18MOV017', 'Raj Kapoor');
insert into actors values ('BT16CSE018', 'Prachita');
insert into actors values ('AC18MOV011', 'Nawab');

insert into movies values ('MOV01','DDLJ');
insert into movies values ('MOV02','The Kid');
insert into movies values ('MOV03','Titanic');
insert into movies values ('MOV05','Mera Nam Joker');

insert into actor_role values ('MOV01','AC18MOV002','Raj');
insert into actor_role values ('MOV01','BT16CSE018','Simran');
insert into actor_role values ('MOV02','AC18MOV008','Tramp');
insert into actor_role values ('MOV02','AC18MOV008','Trunk');
insert into actor_role values ('MOV02','AC18MOV008','Tom');
insert into actor_role values ('MOV03','AC18MOV008','Cal');
insert into actor_role values ('MOV03','AC18MOV015','Jack');
insert into actor_role values ('MOV03','BT16CSE012','Rose');
insert into actor_role values ('MOV05','AC18MOV017','Raju');

# Query 11

select  Title, count(Rolename) as Roles from movies, actor_role where movies.MID  = actor_role.MID and AID = (select AID from actors where Name='Charlie Chaplin') group by Title ;

# Query  12
select Name from actors where AID not in ( select AID from actor_role );

# Query 13

select Name, Title from actors, movies ,actor_role where actors.AID = actor_role.AID and movies.MID = actor_role.MID

union

select Name, NULL from actors AS L
WHERE NOT EXISTS ( select * from movies as R, actor_role where L.AID =actor_role.AID and R.MID = actor_role.MID);
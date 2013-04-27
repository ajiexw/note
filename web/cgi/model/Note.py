#coding=utf-8
from Model import Model

class Note(Model):
    table_name = 'Note'
    column_names = ['Userid', 'title', 'content']

    table_template = \
        ''' CREATE TABLE {$table_name} (
            {$table_name}id int unsigned not null auto_increment,
            Userid          int unsigned not null,
            NoteCategoryid  int unsigned  not null default 0,
            title           varchar(200)  charset utf8 not null default '',
            content         varchar(8000) charset utf8 not null default '',
            primary key     ({$table_name}id),
            key             (Userid)
        )ENGINE=InnoDB; '''

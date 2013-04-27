#coding=utf-8
import site_helper as sh

# ../page/NoteAdd.html

class NoteAdd:

    def GET(self):
        assert sh.session.is_login, '请先登录'
        return sh.page.NoteAdd()

    def POST(self, inputs=None):
        if not inputs: inputs = sh.inputs()
        new_id = sh.model('Note').insert(inputs)
        return sh.alert('注册成功')

   


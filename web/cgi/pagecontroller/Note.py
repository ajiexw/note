#coding=utf-8
import site_helper as sh

# ../../page/Note.html

class Note:

    def GET(self, note_id):
        note_id = int(note_id)
        note = sh.model('Note').get(note_id)
        note.title = sh.getUnicodeSummary(note.content, 20)
        return sh.page.Note(note)

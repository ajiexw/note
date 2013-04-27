#coding=utf-8
import site_helper as sh

# ../page/Index.html

class Index:

    def GET(self):
        notes = sh.model('Note').all({'paging': True, 'paging_volume': 15, 'orderby':'Noteid desc'})
        for note in notes:
            note.title = sh.getUnicodeSummary(note.content, 25)
            note.summary = sh.getUnicodeSummary(note.content, 200)
        return sh.page.Index(notes)

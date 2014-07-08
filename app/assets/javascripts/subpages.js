var opts = {
  container: 'epiceditor',
  textarea: 'subpage_body',
  basePath: '',

  theme: {
        base: '/assets/epiceditor.css',
        preview: '/assets/github.css',
        editor: '/assets/epic-dark.css'
  }
}

var doneEpicEditorSetup = false;

var setupEpicEditor = function() {
  if (!doneEpicEditorSetup) {
    var editor = new EpicEditor(opts).load();
    doneEpicEditorSetup = true;
  }
}
    
$(document).ready(setupEpicEditor);
$(document).on("page:load", setupEpicEditor);
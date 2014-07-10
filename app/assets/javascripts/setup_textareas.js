var setupTextarea = function (textareaId) {
  var opts = {
    container: 'epiceditor',
    textarea: textareaId,
    localStorageName: textareaId,
    basePath: '',

    theme: {
          base: '/assets/epiceditor.css',
          preview: '/assets/github.css',
          editor: '/assets/epic-dark.css'
    }
  }

  var doneEpicEditorSetup = false;

  var setupEpicEditor = function() {
    if (!doneEpicEditorSetup && $("#" + textareaId).length > 0) {
      var editor = new EpicEditor(opts).load();
      doneEpicEditorSetup = true;
    }
  }

  $(document).ready(setupEpicEditor);
  $(document).on("page:load", setupEpicEditor);
}

setupTextarea('subpage_body');
setupTextarea('page_body');
setupTextarea('wiki_body');
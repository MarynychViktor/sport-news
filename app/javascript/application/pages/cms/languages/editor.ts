import jsyaml from 'js-yaml'
declare const ace: any;

export function validateYaml(code) {
  let error;
  try {
    jsyaml.load(code)
  } catch (e) {
    error = e
  }

  return error;
}

export function createEditor(code: string) {
  const editor = ace.edit("editor");
  editor.setTheme("ace/theme/eclipse");
  editor.setSession(ace.createEditSession(code, 'ace/mode/yaml'));
  editor.setOptions({fontSize: "16px"});


  editor.on('change', () => {
    const code = editor.getValue();
    const error: any = validateYaml(code);

    if (error) {
      editor.getSession().setAnnotations([{
        row: error.mark.line,
        column: error.mark.column,
        text: error.reason,
        type: 'error'
      }]);
    } else {
      editor.getSession().setAnnotations([])
    }
  });

  return editor;
}

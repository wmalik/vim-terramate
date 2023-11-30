let s:cpo_save = &cpoptions
set cpoptions&vim

function! terramate#fmt() abort
  silent execute 'w !'.g:terramate_binary_path.' fmt'
  if v:shell_error == 0
    return
  endif
endfunction

function! terramate#commands(ArgLead, CmdLine, CursorPos) abort
  let commands = [
    \ 'list',
    \ 'run',
    \ 'version',
    \ 'create',
    \ 'generate'
  \ ]
  return join(commands, "\n")
endfunction


fun! TerramateDocs()
    if &ft =~ "terramate"
      let s:base_url = "https://terramate.io/docs/cli"
      let s:word = expand("<cword>")
      if s:word[0:2] == "tm_"
        let s:type_mapping = {}
        let s:type_mapping["tm_ternary"] = "functions/terramate-builtin"
        let s:type_mapping["tm_hcl_expression"] = "functions/terramate-builtin"
        let s:type_mapping["tm_version_match"] = "functions/terramate-builtin"

        let s:type = s:type_mapping[s:word]
        let s:type = get(s:type_mapping, s:word, "functions")
        let s:url = join([s:base_url, s:type, s:word], "/")
        silent exec "!xdg-open '".s:url."'"
        silent exec "redra!"
      else
          echo "only tm_* functions are supported at the moment"
      endif
    else
      return
    endif
endfun


let &cpoptions = s:cpo_save
unlet s:cpo_save

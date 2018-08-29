if exists('g:loaded_atcoder_submitter')
  finish
endif

let g:loaded_atcoder_submitter = 1

scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

let s:submitter = yarp#py3('AtCoderSubmitter')

function! s:input(...) abort
  new
  cnoremap <buffer> <Esc> __CANCELED__<CR>
  try
    let input = call('input', a:000)
    let input = input =~# '__CANCELED__$' ? 0 : input
  catch /^Vim:Interrupt$/
    let input = -1
  finally
    bwipeout!
    return input
  endtry
endfunction

let g:AtCoderSubmitter#LanguageID = 3003


function g:AtCoderSubmitter#Submit()
  let contest_id = input('contest_id :')
  let problem_id = input('problem_id :')
  if input('OK? [y/n] :') == 'y'
    call s:submitter.request('SubmitCode',$ATCODER_USERNAME,$ATCODER_PASSWORD,contest_id,problem_id)
    echo 'Submmit'
  endif
endfunction

com ACSubmit call g:AtCoderSubmitter#Submit()


let &cpo = s:save_cpo
unlet s:save_cpo
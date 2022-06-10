" Highlight keywords FIXME TODO XXX like usual.
syntax case match
syn clear CfgComment
syn match CfgComment "#.*"    contains=CfgTodo,@Spell
syn match CfgComment ";.*"    contains=CfgTodo,@Spell
syn match CfgComment "\/\/.*" contains=CfgTodo,@Spell
syntax keyword CfgTodo contained FIXME TODO XXX
highlight default link CfgTodo Todo

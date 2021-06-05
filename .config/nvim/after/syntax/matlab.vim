if exists('g:no_vim_conceal') || !has('conceal') || &enc != 'utf-8'
    finish
endif

syntax keyword matlabStatement Inf
syntax match matlabOperator	"@"

" comparators
syntax match matlabOperator "<=" conceal cchar=≤
syntax match matlabOperator ">=" conceal cchar=≥
syntax match matlabOperator "[=~]=" conceal cchar=≢
syntax match matlabOperator "==" conceal cchar=≐
"syntax match matlabOperator "=" conceal cchar=←
syntax match matlabOperator	"&&" conceal cchar=∧
syntax match matlabOperator	"||" conceal cchar=∨
syntax match matlabOperator "~" conceal cchar=¬

" math related
syntax match matlabOperator "[.]/" conceal cchar=÷
syntax match matlabOperator "[.]\*" conceal cchar=×
syntax match matlabOperator "@" conceal cchar=λ
syntax match matlabOperator "\( \|\)[.]\^\( \|\)2\>" conceal cchar=²
syntax match matlabOperator "\( \|\)[.]\^\( \|\)3\>" conceal cchar=³

syntax match matlabKeyword "\<pi\>" conceal cchar=π

" keywords
syntax keyword matlabFunction function conceal cchar=ƒ
syntax keyword matlabStatement sqrt conceal cchar=√
syntax keyword matlabStatement sum conceal cchar=∑
syntax keyword matlabStatement Inf conceal cchar=∞

hi link matlabOperator Operator
hi link matlabStatement Statement
hi link matlabKeyword Keyword
hi! link Conceal Operator

setlocal conceallevel=1

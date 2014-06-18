function Test(path)

	let cs_file = a:path . "/cscope.out"
	if filereadable(cs_file)
		cs add cs_file
		return
	endif
	echo cs_file

	let cs_path = system("dirname " . a:path)
	let cs_path = substitute(cs_path, '^\(.*\)\n$', '\1', '')

	if cs_path == "/"
		echo "Could not find a cscope.out file."
		return
	endif

	call Test(cs_path)
endfunction

call Test("/home/kokoro/dv/system_scripts/")

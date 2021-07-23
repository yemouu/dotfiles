# ebuild
hook global BufCreate .*\.ebuild %{
	set-option buffer filetype sh
}

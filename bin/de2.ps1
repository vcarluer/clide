param($branch)
if ($branch)
{
	cd "$env:workspace\$env:project\branches\$branch"
}
else
{
	cd "$env:workspace\$env:project"
}

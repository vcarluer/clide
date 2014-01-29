param($branch)
if ($branch)
{
	cd "c:\dotNet\Projects\PlannerOne\branches\$branch"
}
else
{
	cd "c:\dotNet\Projects\PlannerOne\trunk"
}

#!/bin/sh
# hook to sync taskwarrior whenever a task has been modified
# the modified check is critical to avoid a loop where sync triggers the hook which triggers sync...

n=0
while read modified_task
do
    n=$(($n + 1))
done

if (($n > 0)); then
    task sync &> /dev/null
fi

exit 0

repoList="cstor-csi mayastor zfs-localpv lvm-localpv dynamic-localpv-provisioner"

for repo in $repoList
do
	git clone -q "https://github.com/openebs/$repo"
	cd "$repo"

	total=`git log | grep -c "Author:"`
	#handle multiple sign off in a single commit
	missing=`git log | grep -e Author -e Signed.*off.*by | sed 's/    //'| bbe -e 's/\nSigned/ Signed/' | grep -v Signed.*off.*by | wc -l`

	echo "$repo $missing/$total"
	cd ..
	rm -rf "$repo"
done

#git log | grep -e commit -e Author -e Signed-off-by | sed 's/    //'bbe -e 's/\nAuthor/ Author/' | bbe -e 's/\nSigned/ Signed/' | grep -v Signed-off-by | wc -l

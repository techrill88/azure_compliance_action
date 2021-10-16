
echo "Goodbye  : $1 "

export AZURE_SUBSCRIPTION_ID=$2
export AZURE_CLIENT_ID=$3
export AZURE_TENANT_ID=$4
export AZURE_CLIENT_SECRET=$5

test_file_name = $6

curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec 
cp -r $1/app/inspec-azure-check-profile .


#REM inspec exec . -t azure:// --reporter cli junit:testresults.xml html:report.html --chef-license accept-silent
#REM inspec check inspec-azure-check-profile --chef-license accept-silent
inspec exec inspec-azure-check-profile/ -t azure:// --chef-license accept-silent

if [$test_file_name]
then
    inspec exec $test_file_name -t azure:// --chef-license accept-silent
fi
